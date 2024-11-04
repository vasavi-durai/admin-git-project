const License = require('../models/license');

exports.getLicense = async (req, res) => {
    const { licenseID } = req.query;
    try {
        if (licenseID) {
            const license = await License.findOne({ licenseID });
            if (!license) return res.status(404).json({ error: 'License not found' });
            return res.json(license);
        }
        const licenses = await License.find();
        res.json(licenses);
    } catch (error) {
        console.error("Get License Error:", error.message, error.stack);
        res.status(500).json({ error: 'Server error' });
    }
};

exports.createLicense = async (req, res) => {
    const { licenseID, expireDate, associatedGUID } = req.body;
    if (!licenseID || !expireDate) {
        return res.status(400).json({ error: 'License ID and expiry date are required' });
    }
    try {
        const newLicense = new License({
            licenseID,
            expireDate: new Date(expireDate),
            associatedGUID
        });
        await newLicense.save();
        res.status(201).json({ message: 'License created successfully', license: newLicense });
    } catch (error) {
        console.error("Create License Error:", error.message, error.stack);
        if (error.code === 11000) {
            return res.status(400).json({ error: 'License ID must be unique' });
        }
        res.status(500).json({ error: 'Server error' });
    }
};
exports.updateLicense = async (req, res) => {
    const { id: licenseID } = req.params; 
    const { expireDate, associatedGUID } = req.body;
    
    try {
        const updateData = {};
        
        if (expireDate) {
            updateData.expireDate = new Date(expireDate);
        }
        if (associatedGUID !== undefined) {
            updateData.associatedGUID = associatedGUID;
        }
        
        const license = await License.findOneAndUpdate(
            { licenseID },  
            updateData,
            { new: true }
        );
        
        if (!license) {
            return res.status(404).json({ error: 'License not found' });
        }
        
        res.json({ message: 'License updated successfully', license });
    } catch (error) {
        console.error("Update License Error:", error.message, error.stack);
        res.status(500).json({ error: 'Server error' });
    }
};


exports.removeGUID = async (req, res) => {
    const { licenseID } = req.params; 
    try {
      const license = await License.findOneAndUpdate(
        { licenseID: licenseID },
        { $set: { associatedGUID: null } },
        { new: true }
      );
      if (!license) return res.status(404).json({ error: 'License not found' });
      res.json({ message: 'GUID removed successfully', license });
    } catch (error) {
      console.error("Remove GUID Error:", error.message, error.stack);
      res.status(500).json({ error: 'Server error' });
    }
  };
  

exports.deleteLicense = async (req, res) => {
    const { id: licenseID } = req.params;
    try {
        const license = await License.findOneAndDelete({ licenseID: licenseID });
        if (!license) return res.status(404).json({ error: 'License not found' });
        res.json({ message: 'License deleted successfully' });
    } catch (error) {
        console.error("Delete License Error:", error.message, error.stack);
        res.status(500).json({ error: 'Server error' });
    }
};


// exports.updateLicense = async (req, res) => {
//     const { id } = req.params;
//     const { expireDate, associatedGUID } = req.body;
//     try {
//         const updateData = {};
        
//         if (expireDate) {
//             updateData.expireDate = new Date(expireDate);
//         }
//         if (associatedGUID !== undefined) {
//             updateData.associatedGUID = associatedGUID; 
//         }
//         const license = await License.findByIdAndUpdate(id, updateData, { new: true });
//         if (!license) return res.status(404).json({ error: 'License not found' });
//         res.json({ message: 'License updated successfully', license });
//     } catch (error) {
//         console.error("Update License Error:", error.message, error.stack);
//         res.status(500).json({ error: 'Server error' });
//     }
// };
