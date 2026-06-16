const express = require('express');
const cors = require('cors');
require('dotenv').config();

const app = express();
app.use(cors());
app.use(express.json());
app.use(express.static('public'));

app.use('/api/stolovi', require('./routes/stolovi'));
app.use('/api/artikli', require('./routes/artikli'));
app.use('/api/narudzbe', require('./routes/narudzbe'));
app.use('/api/assistant', require('./routes/assistant'));
app.use('/api/pozivi', require('./routes/pozivi'));
app.use('/api/statistike', require('./routes/statistike'));

const PORT = process.env.PORT || 3000;
app.listen(PORT, () => console.log(`Server radi na portu ${PORT}`));