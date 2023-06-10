module ProposalsHelper

  def keyword_options
    [["Abuse and Domestic Violence",
      [
        "Bullying",
        "Emotional Abuse",
        "Physical Abuse: Child, Partner, Elder"
      ]
    ],
    ["Consultation and Collaboration On:",
      [
        "Collaborative Care",
        "Community Issues and Systems",
        "Homelessness, Migration, Resettlement",
        "Medical Issues and Systems"
      ]
    ],
    ["Education and Training of Therapists",
      [
        "Educational Preparation",
        "Clinical Training",
        "Supervision",
        "Therapy and Personal Growth",
        "Program Development",
        "Systemic Theory"
      ]
    ],
    ["Family Development",
      [
        "Clinical Implications of Family Development",
        "Theories of Family Development and Clinical Interventions",
        "Child Development and Its Implications",
        "Parenting"
      ]
    ],
    ["Legal Regulation of Therapy/Therapists",
      [
        "Certification, Licensure, Regulation Issues"
      ]
    ],
    ["Research: Evaluation of Therapy",
      [
        "Evidence Based Treatment",
        "Methodology",
        "Outcome Research",
        "Process Research",
        "State of Knowledge"
      ]
    ],
    ["Therapy",
      [
        "Couple and Marital Therapy",
        "Family Therapy"
      ]
    ],
    ["Trauma and Healing",
      [
        "Accident and Injury",
        "Natural Catastrophe",
        "Terrorism",
        "Torture",
        "War/Political"
      ]
    ],
    ["Other",
      [
        "Coaching",
        "Death Dying, Bereavement, Loss",
        "Divorce and Remarriage",
        "Legal Systems and Courts",
        "Mental Health and Illness",
        "Spirituality",
      ]
    ]]
  end

  def show_languages(proposal)
    languages = ""
    languages += "English, " if proposal.language_english
    languages += "Mandarin, " if proposal.language_mandarin
    languages += "Japanese, " if proposal.language_japanese
    languages += "Korean, " if proposal.language_korean
    languages.chomp(", ")
  end

  # IFTA only has one review per proposal
  # loading the most recent review or creating a new review
  def current_review(proposal)
    proposal.reviews.last || Review.new
  end
end
