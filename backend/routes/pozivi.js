const router = require('express').Router();
const db = require('../db');

// POST novi poziv
router.post('/', async (req, res) => {
  const { id_stol, broj_stola } = req.body;
  try {
    await db.query(
      'INSERT INTO Poziv (id_stol, vrijeme, rijeseno) VALUES (?, NOW(), 0)',
      [id_stol]
    );
    res.json({ success: true });
  } catch (err) {
    res.status(500).json({ error: err.message });
  }
});

// GET svi neriješeni pozivi
router.get('/', async (req, res) => {
  try {
    const [rows] = await db.query(`
      SELECT p.id_poziv, p.vrijeme, s.broj AS broj_stola
      FROM Poziv p
      JOIN Stol s ON p.id_stol = s.id_stol
      WHERE p.rijeseno = 0
      ORDER BY p.vrijeme DESC
    `);
    res.json(rows);
  } catch (err) {
    res.status(500).json({ error: err.message });
  }
});

// PUT označi kao riješeno
router.put('/:id/rijesi', async (req, res) => {
  try {
    await db.query('UPDATE Poziv SET rijeseno = 1 WHERE id_poziv = ?', [req.params.id]);
    res.json({ success: true });
  } catch (err) {
    res.status(500).json({ error: err.message });
  }
});

module.exports = router;