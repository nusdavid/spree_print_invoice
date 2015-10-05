font "Helvetica"

im = Rails.application.assets.find_asset(Spree::PrintInvoice::Config[:print_invoice_logo_path])
image im , :at => [0,720] #, :scale => 0.35


render :partial => "address"

render :partial => "line_items_box"

move_down 8

# Footer
render :partial => "footer"