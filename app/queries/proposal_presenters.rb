class ProposalPresenters
  def self.exec(conference_id)
    ActiveRecord::Base.connection.select_all(
      ActiveRecord::Base.send(:sanitize_sql_array, [
        "select
          a.email,
          listed_count,
          COALESCE(accepted_count, 0) as accepted_count
        from
          (select
            email,
            count(email) as listed_count
          from presenters
          inner join proposals
          on proposals.id = presenters.proposal_id
          where proposals.conference_id = 11
          group by email) a
        left join
          (select email,
          count(email) as accepted_count
          from presenters
          left join proposals
          on proposals.id = presenters.proposal_id && proposals.status = 'accept'
          where proposals.conference_id = ?
          group by email) b
          on a.email = b.email",
        conference_id]
      )
    )
  end
end