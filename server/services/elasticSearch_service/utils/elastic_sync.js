const { getElastic } = require("../../../shared/config/elasticsearch");

const addDoc = async (product) => {
  try {
    const { productElastic } = getElastic();
    await productElastic.index({
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
  } catch (error) {
    throw new Error("Đồng bộ hóa elasticSearch không thành công");
  }
};

const updateRating = async (product) => {
try {
  const { productElastic } = getElastic();
  await productElastic.index({
    index: "ratings",
    id: product._id.toString(),
    body: {
      keys: product.keys,
      product_id: product.product_id,
      ratings: product.ratings,
      user_id: product.user_id,
      createdAt: product.createdAt.toString(),
      updatedAt: product.updatedAt.toString(),
    },
  });

} catch (error) {
  console.log(error.message);
  throw new Error("Đồng bộ hóa elasticSearch không thành công");
 }
}
const deleteDoc = async (id) => {
  try {
    const { productElastic } = getElastic();

    const res = await productElastic.delete({
      index: "allpost",
      id: id,
    });

  } catch (error) {
    throw new Error(error.message);
  }
};


module.exports = { addDoc, deleteDoc, updateRating };
