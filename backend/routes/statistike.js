const router = require('express').Router();
const db = require('../db');

// Ukupna statistika
router.get('/', async (req, res) => {
  try {
    const [[ukupnoNarudzbi]] = await db.query(`
  SELECT COUNT(*) as ukupno
  FROM Narudzba n
  JOIN Status s ON n.id_status = s.id_status
  WHERE s.status = 'Plaćeno'
`);

    const [[ukupnoProhoda]] = await db.query(`
  SELECT COALESCE(SUM(sn.kolicina * a.cijena), 0) as prihod
  FROM Stavka_narudzbe sn
  JOIN Narudzba n ON sn.id_narudzba = n.id_narudzba
  JOIN Status s ON n.id_status = s.id_status
  JOIN Artikl a ON sn.id_artikl = a.id_artikl
  WHERE s.status = 'Plaćeno'
`);

    const [[ukupnoUpita]] = await db.query(
      'SELECT COUNT(*) as ukupno FROM Upit_Asistentu'
    );

    const [[preporukeKliknute]] = await db.query(
      'SELECT COUNT(DISTINCT id_upit) as ukupno FROM Preporuka_Asistenta'
    );

    const [najprodavanijiArtikli] = await db.query(`
  SELECT a.naziv, k.naziv AS kategorija,
         SUM(sn.kolicina) as prodano,
         SUM(sn.kolicina * a.cijena) as prihod
  FROM Stavka_narudzbe sn
  JOIN Narudzba n ON sn.id_narudzba = n.id_narudzba
  JOIN Status s ON n.id_status = s.id_status
  JOIN Artikl a ON sn.id_artikl = a.id_artikl
  JOIN Kategorija k ON a.id_kategorija = k.id_kategorija
  WHERE s.status = 'Plaćeno'
  GROUP BY a.id_artikl
  ORDER BY prodano DESC
  LIMIT 10
`);

    const [prihodPoKategoriji] = await db.query(`
  SELECT k.naziv AS kategorija,
         SUM(sn.kolicina) as prodano,
         SUM(sn.kolicina * a.cijena) as prihod
  FROM Stavka_narudzbe sn
  JOIN Narudzba n ON sn.id_narudzba = n.id_narudzba
  JOIN Status s ON n.id_status = s.id_status
  JOIN Artikl a ON sn.id_artikl = a.id_artikl
  JOIN Kategorija k ON a.id_kategorija = k.id_kategorija
  WHERE s.status = 'Plaćeno'
  GROUP BY k.id_kategorija
  ORDER BY prihod DESC
`);

    const [narudzbePoSatu] = await db.query(`
  SELECT HOUR(n.vrijeme) as sat, COUNT(*) as narudzbi
  FROM Narudzba n
  JOIN Status s ON n.id_status = s.id_status
  WHERE s.status = 'Plaćeno'
  GROUP BY HOUR(n.vrijeme)
  ORDER BY sat
`);

    const [preporukeAsistenta] = await db.query(`
      SELECT a.naziv, COUNT(*) as preporuceno
      FROM Preporuka_Asistenta pa
      JOIN Artikl a ON pa.id_artikl = a.id_artikl
      GROUP BY a.id_artikl
      ORDER BY preporuceno DESC
      LIMIT 5
    `);

    const [narudzbePoStatusu] = await db.query(`
      SELECT s.status, COUNT(*) as ukupno
      FROM Narudzba n
      JOIN Status s ON n.id_status = s.id_status
      GROUP BY n.id_status
    `);

    res.json({
      ukupnoNarudzbi: ukupnoNarudzbi.ukupno,
      ukupniPrihod: parseFloat(ukupnoProhoda.prihod),
      ukupnoUpita: ukupnoUpita.ukupno,
      uspjesnostAsistenta: ukupnoUpita.ukupno > 0
        ? Math.round((preporukeKliknute.ukupno / ukupnoUpita.ukupno) * 100)
        : 0,
      najprodavanijiArtikli,
      prihodPoKategoriji,
      narudzbePoSatu,
      preporukeAsistenta,
      narudzbePoStatusu,
    });
  } catch (err) {
    console.error('Greška statistike:', err);
    res.status(500).json({ error: err.message });
  }
});

module.exports = router;