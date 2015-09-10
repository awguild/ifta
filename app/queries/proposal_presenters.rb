class ProposalPresenters
  def self.exec(conference_id)
    ActiveRecord::Base.connection.select_all(
      ActiveRecord::Base.send(:sanitize_sql_array, [
        "select
          a.email,
          listed_count,
          COALESCE(slotted_count, 0) as slotted_count
        from
          (select
            email,
            count(email) as listed_count
          from presenters
          inner join proposals
          on proposals.id = presenters.proposal_id
          where proposals.conference_id = ?
          group by email) a
        left join
          (select
            email,
            count(email) as slotted_count
          from presenters
          inner join proposals
          on proposals.id = presenters.proposal_id
          inner join slots
          on slots.proposal_id = proposals.id
          where proposals.conference_id = ?
          group by email) b
        on a.email = b.email",
        conference_id, conference_id]
      )
    )
  end
end