const mongoose = require('mongoose');

const licenseSchema = new mongoose.Schema({
    licenseID: { type: String, unique: true, required: true },
    expireDate: { type: Date, required: true },
    associatedGUID: { type: String }
});

module.exports = mongoose.model('License', licenseSchema);
