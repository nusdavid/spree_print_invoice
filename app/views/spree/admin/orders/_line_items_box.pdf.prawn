data = []

if @hide_prices
  @column_widths = { 0 => 100, 1 => 165, 2 => 75, 3 => 75 }
  @align = { 0 => :left, 1 => :left, 2 => :right, 3 => :right }
  data << [Spree.t(:sku), Spree.t(:product), Spree.t(:qty)]
else
  @column_widths = { 0 => 200, 1 => 205, 2 => 100 }
  @align = { 0 => :left, 1 => :left, 2 => :left}
  data << [Spree.t(:product), Spree.t(:qty), Spree.t(:price)]
end

@order.line_items.each do |item|
  row = [ item.variant.product.search, item.variant.quantity.try(:presentation) || item.quantity]
  row << item.single_display_amount.to_s unless @hide_prices
  data << row
end

extra_row_count = 0

unless @hide_prices
  extra_row_count += 1
  data << [""] * 5
  data << [nil, nil, Spree.t(:subtotal), @order.display_item_total.to_s]

  @order.all_adjustments.eligible.each do |adjustment|
    extra_row_count += 1
    data << [nil, nil, adjustment.label, adjustment.display_amount.to_s]
  end

  @order.shipments.each do |shipment|
    extra_row_count += 1
    data << [nil, nil, Spree.t(:shipment), shipment.display_cost.to_s]
  end

  data << [nil, nil, Spree.t(:total), @order.display_total.to_s]
end

move_down 255
table(data, :width => 525) do
  cells.border_width = 0.5

  row(0).borders = [:bottom]
  row(0).font_style = :bold
  row(0).background_color = 'D3D3D3'

  last_column = data[0].length - 1
  row(0).columns(0..last_column).borders = [:top, :right, :bottom, :left]
  row(0).columns(0..last_column).border_widths = [0.5, 0, 0.5, 0.5]

  row(0).column(last_column).border_widths = [0.5, 0.5, 0.5, 0.5]

  if extra_row_count > 0
    extra_rows = row((-2-extra_row_count)..-2)
    extra_rows.columns(0..5).borders = []
    extra_rows.column(4).font_style = :bold

    row(-1).columns(0..5).borders = []
    row(-1).column(4).font_style = :bold
  end
end

move_down data.size