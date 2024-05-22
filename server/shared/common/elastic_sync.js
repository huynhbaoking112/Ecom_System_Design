const {getElastic} = require("../config/elasticsearch");

const addDoc = (product) => {
  const {productElastic} = getElastic()
  productElastic.index({
    index: "allpost",
    id: product._id.toString(),
    body: {
      name: product.name,
      description: product.description,
      images: product.images,
      quantity: product.quantity,
      price: product.price,
      category: product.category,
      createdAt: product.createdAt.toString(),
      updatedAt: product.updatedAt.toString(),
    },
  });
};

module.exports = addDoc;
