const errorGloblal = (err, req, res, next) => {
    console.log(err);
    res.status(!err.statusCode ? 500 : err.statusCode).json({
        message: err.message
    })
}

module.exports = errorGloblal