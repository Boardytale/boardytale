part of user_utils;

Future<Response> getShopItems(core.ToUserServerMessage message, ManagedContext context) async {
  message.addItemsToShop(itemsData.values.toList());
  return Response.ok(message.toJson());
}
