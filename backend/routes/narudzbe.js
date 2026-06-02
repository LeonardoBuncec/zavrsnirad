const router = require('express').Router();
const db = require('../db');

// POST nova narudžba sa stavkama
router.post('/', async (req, res) => {
  const { id_stol, stavke } = req.body;

  const conn = await db.getConnection();
  try {
    await conn.beginTransaction();

    const [result] = await conn.query(
      'INSERT INTO Narudzba (id_stol, id_status, vrijeme) VALUES (?, 1, NOW())',
      [id_stol]
    );
    const id_narudzba = result.insertId;

    for (const stavka of stavke) {
      await conn.query(
        'INSERT INTO Stavka_narudzbe (id_narudzba, id_artikl, kolicina) VALUES (?, ?, ?)',
        [id_narudzba, stavka.id_artikl, stavka.kolicina]
      );
    }

    await conn.commit();
    res.json({ success: true, id_narudzba });
  } catch (err) {
    await conn.rollback();
    console.error('Greška narudžba:', err);
    res.status(500).json({ error: err.message });
  } finally {
    conn.release();
  }
});

// GET sve narudžbe za staff
router.get('/', async (req, res) => {
  try {
    const [narudzbe] = await db.query(`
      SELECT n.id_narudzba, n.vrijeme, n.id_stol, s.broj AS broj_stola, st.status, n.id_status
      FROM Narudzba n
      JOIN Stol s ON n.id_stol = s.id_stol
      JOIN Status st ON n.id_status = st.id_status
      ORDER BY n.vrijeme DESC
    `);

    for (const n of narudzbe) {
      const [stavke] = await db.query(`
        SELECT sn.kolicina, a.naziv, a.cijena
        FROM Stavka_narudzbe sn
        JOIN Artikl a ON sn.id_artikl = a.id_artikl
        WHERE sn.id_narudzba = ?
      `, [n.id_narudzba]);
      n.stavke = stavke;
    }

    res.json(narudzbe);
  } catch (err) {
    res.status(500).json({ error: err.message });
  }
});

// PUT promjena statusa
router.put('/:id/status', async (req, res) => {
  const { id_status } = req.body;
  try {
    await db.query(
      'UPDATE Narudzba SET id_status = ? WHERE id_narudzba = ?',
      [id_status, req.params.id]
    );
    res.json({ success: true });
  } catch (err) {
    res.status(500).json({ error: err.message });
  }
});

module.exports = router;