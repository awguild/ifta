class PresentersQuery
  def self.to_csv(presentations)
    CSV.generate do |csv|
      csv << [
        'id',
        'title',
        'type',
        'last_name',
        'first_name',
        'primary',
        'email',
        'country',
        'date_accepted',
        'date_emailed',
        'payment_date',
        'payment_type',
        'registration',
        'amount_paid',
        'payment_confirmed',
        'invite_letter',
        'notes'
      ]

      presentations.each(:as => :hash) do |registration|
        csv << [
          registration['relative_number'],
          registration['title'],
          registration['type'],
          registration['last_name'],
          registration['first_name'],
          registration['primary'],
          registration['email'],
          registration['country'],
          registration['date_accepted'],
          'N/A',
          registration['payment_date'],
          registration['payment_method'],
          'N/A',
          registration['amount_paid'],
          registration['payment_confirmed'],
          'N/A',
          'N/A'
        ]
      end
    end
  end

  def self.exec(conference_id)
    ActiveRecord::Base.connection.execute(
    "SELECT relative_number,
       title,
       format               AS type,
       presenters.last_name,
       presenters.first_name,
       CASE
         WHEN proposals.user_id = users.id THEN 'primary'
         ELSE 'secondary'
       end                  AS primary_presenter,
       presenters.email,
       countries.name       AS country,
       proposals.updated_at AS date_accepted,
       payments.created_at  AS payment_date,
       transactions.payment_method,
       status,
       payments.amount      AS amount_paid,
       CASE
       WHEN (transactions.paid = true AND payments.confirmed = true) THEN 'yes' ELSE 'no' END as payment_confirmed
    FROM   proposals
    INNER JOIN presenters
    ON presenters.proposal_id = proposals.id
    LEFT JOIN users
    ON users.email = presenters.email
    LEFT JOIN itineraries
    ON itineraries.user_id = users.id AND itineraries.conference_id = #{conference_id}
    LEFT JOIN countries
    ON countries.id = users.country_id
    LEFT JOIN transactions
    ON transactions.itinerary_id = itineraries.id
    LEFT JOIN payments
    ON payments.transaction_id = transactions.id
    WHERE proposals.conference_id = #{conference_id}
    AND proposals.status = 'accept'
    ORDER BY relative_number")
  end
end
