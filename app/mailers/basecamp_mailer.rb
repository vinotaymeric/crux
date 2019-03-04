class BasecampMailer < ApplicationMailer
  def notification(basecamp)
    @basecamp = basecamp

    mail(
      to:       @basecamp.user.email,
      subject:  "Mise à jour #{@basecamp.name} !"
    )
  end
end
