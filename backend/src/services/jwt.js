const jwt = require('jsonwebtoken')

// Hashing the passwords
// const secret = process.env.JWT_SECRET
const secret = ""

const signToken = (payload) => jwt.sign(payload, secret, { expiresIn: '1h' })

const verifyToken = (token) => jwt.verify(token, secret, (err, res) => {
    if (err) throw err
    return res
})

const verifyHeader = (req) => {
    const token = req.headers.authorization.replace('Bearer ', '')
    const decoded = verifyToken(token);
    return decoded
}

module.exports = {
    signToken,
    verifyToken,
    verifyHeader
}