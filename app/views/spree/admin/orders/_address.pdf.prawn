move_down 70
text "Thank you for placing an order with Tweegy. Your high quality printed items are enclosed, we’re confident you’ll love them!"
bill_address = @order.bill_address
ship_address = @order.ship_address
anonymous = @order.email =~ /@example.net$/


def address_info(address)
  info = %Q{
    #{address.first_name} #{address.last_name}
    #{address.address1}
  }
  info += "#{address.address2}\n" if address.address2.present?
  state = address.state ? address.state.abbr : ""
  info += "#{address.zipcode} #{address.city} #{state}\n"
  info += "#{address.country.name}\n"
  info += "#{address.phone}\n"
  info.strip
end


data = [
  [Spree.t(:billing_address), Spree.t(:shipping_address)],
  [address_info(bill_address), address_info(ship_address)]
]

move_down 10
table(data, :width => 525) do
  row(0).font_style = :bold

  # Billing address header
  row(0).column(0).borders = [:top, :right, :bottom, :left]
  row(0).column(0).border_widths = [0, 0, 0, 0]

  # Shipping address header
  row(0).column(1).borders = [:top, :right, :bottom, :left]
  row(0).column(1).border_widths = [0, 0, 0, 0]

  # Bill address information
  row(1).column(0).borders = [:top, :right, :bottom, :left]
  row(1).column(0).border_widths = [0, 0, 0, 0]

  # Ship address information
  row(1).column(1).borders = [:top, :right, :bottom, :left]
  row(1).column(1).border_widths = [0, 0, 0, 0]

end

move_down 30
text "Order ##{@order.number}"
move_down 20