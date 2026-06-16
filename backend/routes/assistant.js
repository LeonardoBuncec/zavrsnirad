const router = require('express').Router();
const { GoogleGenerativeAI } = require('@google/generative-ai');
const db = require('../db');
require('dotenv').config();

const genAI = new GoogleGenerativeAI(process.env.GEMINI_API_KEY);

async function getMeni() {
  const [artikli] = await db.query(`
    SELECT a.naziv, a.opis, a.cijena, k.naziv AS kategorija
    FROM Artikl a
    JOIN Kategorija k ON a.id_kategorija = k.id_kategorija
    ORDER BY k.naziv, a.naziv
  `);

  const grouped = {};
  for (const a of artikli) {
    if (!grouped[a.kategorija]) grouped[a.kategorija] = [];
    grouped[a.kategorija].push(`${a.naziv} - ${a.opis} (${parseFloat(a.cijena).toFixed(2)}€)`);
  }

  return Object.entries(grouped)
    .map(([kat, items]) => `${kat}:\n${items.map(i => `  - ${i}`).join('\n')}`)
    .join('\n\n');
}

async function getPreporuceniArtikli(odgovor) {
  const [artikli] = await db.query('SELECT id_artikl, naziv FROM Artikl');
  return artikli.filter(a =>
    odgovor.toLowerCase().includes(a.naziv.toLowerCase())
  );
}

router.post('/', async (req, res) => {
  const { upit } = req.body;

  try {
    const meni = await getMeni();

    const systemPrompt = `Ti si AI asistent u restoranu. Pomažeš gostima s preporukama jela i pića.
Odgovaraj kratko i prijateljski na hrvatskom jeziku.
Evo trenutnog menija restorana:\n\n${meni}`;

    const model = genAI.getGenerativeModel({ model: 'gemini-2.5-flash' });
    const result = await model.generateContent(`${systemPrompt}\n\nGost: ${upit}`);
    const odgovor = result.response.text();

    // Spremi upit i odgovor
    const [insertResult] = await db.query(
      'INSERT INTO Upit_Asistentu (upit, odgovor, vrijeme) VALUES (?, ?, NOW())',
      [upit, odgovor]
    );
    const id_upit = insertResult.insertId;

    // Pronađi i spremi preporuke
    const preporuceni = await getPreporuceniArtikli(odgovor);
    for (const artikl of preporuceni) {
      await db.query(
        'INSERT INTO Preporuka_Asistenta (id_upit, id_artikl) VALUES (?, ?)',
        [id_upit, artikl.id_artikl]
      );
    }

res.json({ odgovor, preporuke: preporuceni.map(a => ({ id: a.id_artikl, naziv: a.naziv })) });  } catch (err) {
    console.error('Greška assistant:', err);
    res.status(500).json({ error: err.message });
  }
});

module.exports = router;