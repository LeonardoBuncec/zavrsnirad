const express = require('express');
const cors = require('cors');
require('dotenv').config();

const app = express();
app.use(cors());
app.use(express.json());
app.use(express.static('public')); // ← dodaj ovo

app.use('/api/stolovi', require('./routes/stolovi'));
app.use('/api/artikli', require('./routes/artikli'));
app.use('/api/narudzbe', require('./routes/narudzbe'));

const PORT = process.env.PORT || 3000;
app.listen(PORT, () => console.log(`Server radi na portu ${PORT}`));