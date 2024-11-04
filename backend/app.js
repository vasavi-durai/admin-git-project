const express = require('express');
const logger = require('morgan');
const authRoutes = require('./routes/auth');
const licenseRoutes = require('./routes/license');
const connectDB = require('./config/db');
const cookieParser = require('cookie-parser');
require('dotenv').config();
const cors = require('cors');


const app = express();
const PORT = process.env.PORT || 3000;


app.use(cors());

connectDB();
app.use(cookieParser());
app.use(logger('dev'));
app.use(express.json());
app.use('/api', authRoutes);
app.use('/api', licenseRoutes);

app.use((err, req, res, next) => {
    res.status(err.status || 500);
    res.json({ error: err.message });
});

app.listen(PORT, () => {
    console.log(`Server running on http://localhost: ${PORT}`);
});

module.exports = app;
