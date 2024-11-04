const express = require('express');
const router = express.Router();
const licenseController = require('../controllers/licensecontroller');

router.post('/createlicense', licenseController.createLicense);
router.get('/getlicense', licenseController.getLicense);
router.put('/updatelicense/:id', licenseController.updateLicense); 
router.put('/delguid/:licenseID', licenseController.removeGUID);
router.delete('/dellicense/:id', licenseController.deleteLicense); 

module.exports = router;
