
def index
  LafourchetteScrapper.run
  set_bookings
  @customer = Customer.new
  @customer.bookings.build
  @total_customer = total_customers
  @notification = total_notifications

  @origin = {
            'La Fourchette' => "http://i0.wp.com/lewebcestfood.fr/wp-content/uploads/2016/02/La-fourchette.png?fit=300%2C300",
            'Facebook' => "https://img.icons8.com/color/384/facebook.png",
            'Site Internet' => "https://img.icons8.com/ios/384/internet.png",
            'Phone' => "https://img.icons8.com/metro/384/phone.png",
            'Other' => "https://img.icons8.com/ios/384/conference-call-filled.png"
            }

end

def set_bookings
  if params[:date]
    date = Date.strftime(params[:date][2..-1], "%y/%m/%d")
    @bookings = current_user.restaurant.bookings.where(date: date)
  else
    @bookings = current_user.restaurant.bookings.where(date: Date.today)
  end
end

def create
    customer = Customer.find_by(email: params[:booking][:email])

    if customer.blank?
      customer = Customer.create!(
        email: params[:booking][:email],
        first_name: params[:booking][:first_name],
        last_name: params[:booking][:last_name],
        phone_number: params[:booking][:phone_number]
      )
    end
    # puts "3"*99
    # puts params
    # puts params[:booking][:date]
    # puts params[:date]
    # puts params[:hour]
    # puts params[:hour].class

    booking = Booking.new(
      date: params[:date],
      number_of_customers: params[:booking][:number_of_people],
      source: 'other',
      restaurant: current_user.restaurant,
      customer: customer,
      hour: params[:hour].gsub(":", "h"),
      content: params[:booking][:comments]
    )


    if booking.save
      redirect_to bookings_path + '?date=' + params[:date]
    else
      redirect_to bookings_path, alert: "Votre restaurant est plein"
    end
  end
