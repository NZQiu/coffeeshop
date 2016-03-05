json.items @items do |item|
  json.id   item.id
  json.name item.drink.name.humanize
  json.drink_type item.drink.drink_type.humanize
  json.cup  item.cup_size.humanize
  json.price  "#{"%.2f" % (item.price / 100.0)}"
end
