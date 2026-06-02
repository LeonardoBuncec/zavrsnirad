const router = require('express').Router();
const db = require('../db');

// GET svi artikli s kategorijom
router.get('/', async (req, res) => {
  try {
    const [rows] = await db.query(`
      SELECT a.*, k.naziv AS kategorija
      FROM Artikl a
      JOIN Kategorija k ON a.id_kategorija = k.id_kategorija
    `);
    res.json(rows);
  } catch (err) {
    res.status(500).json({ error: err.message });
  }
});

module.exports = router;