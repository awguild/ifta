class RegistrationBreakdownQuery
  # todo some of the keys should accept arrays and use an in statement
  LINE_ITEM_IDS_2014 = {
    conference: 1,
    conference_and_membership: 0,
    spouse_or_guest: 4,
    ce_certificate: 11
  }
  LINE_ITEM_IDS_2015 = {
    conference: 41,
    conference_and_membership: 51,
    spouse_or_guest: 61,
    ce_certificate: 71
  }

  def self.to_csv(registrations)
    CSV.generate do |csv|
      # headers
      csv << [
        'Member Status',
        'Last Name', 
        'First Name',
        'Email',
        'Country',
        'Registration Status',
        'Payment Date',
        'Payment Type',
        'Total Amount Paid',
        'Conference',
        'Conference + Membership',
        'Spouse / Guest',
        'CE Certificate',
        'Tax',
        'Comments'
      ]

      registrations.each(:as => :hash) do |registration|
        csv << [
          registration['member_status'],
          registration['last_name'],
          registration['first_name'],
          registration['email'],
          registration['country'],
          registration['attendee_type'],
          registration['payment_date'],
          registration['payment_method'],
          registration['total_amount_paid'],
          registration['conference_price'],
          registration['conference_and_membership'],
          registration['spouse_or_guest'],
          registration['ce_certificate'],
          registration['tax'],
          registration['comments']
        ]
      end
    end
  end

  def self.exec(conference_id)
    if conference_id == 11
      items = LINE_ITEM_IDS_2015
    else
      items = LINE_ITEM_IDS_2014
    end

    ActiveRecord::Base.connection.execute(
    "SELECT CASE 
             WHEN u.member = 0 THEN 'non member' 
             WHEN u.member = 1 THEN 'member' 
           end          AS member_status, 
           u.last_name, 
           u.first_name, 
           u.email, 
           c.name       AS country, 
           CASE 
             WHEN (SELECT Count(*) 
                   FROM   proposals AS p 
                   WHERE  p.user_id = u.id 
                          AND status = 'accept') > 0 THEN 'presenter' 
             ELSE 'attendee' 
           end          AS 'attendee_type', 
           CASE 
             WHEN p.confirmed = 1 THEN 'confirmed' 
             WHEN p.confirmed = 0 THEN 'pending' 
           end          AS payment_status, 
           p.created_at AS payment_date, 
           t.payment_method, 
           p.amount     AS total_amount_paid, 
           (SELECT price 
            FROM   line_items 
            WHERE  itinerary_id = i.id 
                   AND line_items.conference_item_id = #{items[:conference]}
                   AND paid = true 
            LIMIT  1)   AS conference_price, 
           (SELECT price 
            FROM   line_items 
            WHERE  itinerary_id = i.id 
                   AND line_items.conference_item_id = #{items[:conference_and_membership]} 
                   AND paid = true 
            LIMIT  1)   AS conference_and_membership, 
           (SELECT price 
            FROM   line_items 
            WHERE  itinerary_id = i.id 
                   AND line_items.conference_item_id = #{items[:spouse_or_guest]} 
                   AND paid = true 
            LIMIT  1)   AS spouse_or_guest, 
           (SELECT price 
            FROM   line_items 
            WHERE  itinerary_id = i.id 
                   AND line_items.conference_item_id = #{items[:ce_certificate]} 
                   AND paid = true 
            LIMIT  1)   AS ce_certificate, 
           CASE 
             WHEN t.paid = 1 THEN t.tax 
           end          AS tax, 
           p.comments 
    FROM   transactions AS t 
           INNER JOIN itineraries AS i 
                   ON t.itinerary_id = i.id 
           INNER JOIN users AS u 
                   ON i.user_id = u.id 
           INNER JOIN countries AS c 
                   ON u.country_id = c.id 
           LEFT JOIN payments AS p 
                  ON p.transaction_id = t.id 
    WHERE  i.conference_id = #{conference_id}")
  end
end