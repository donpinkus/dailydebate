User.create!([
  {provider: "facebook", uid: "100005312476803", name: "Cantika Dewi", email: "don.pinkus@gmail.com", oauth_token: nil, oauth_expires_at: nil},
  {provider: "facebook", uid: "100004740829499", name: "James Morales", email: "don.pinkus@gmail.com", oauth_token: nil, oauth_expires_at: nil},
  {provider: "facebook", uid: "765829480153669", name: "Donald Pinkus", email: "don.pinkus@gmail.com", oauth_token: "CAAKLwjyAgOUBAIX0xu05RRrzZAwJPUId2j1dZBQiHc8cFh6lZAsrHMosxvZCZBfQDYryFx4WfIq4DU0lc30pRZAYBRSdqf3JBYBa10pIo91uePMBSk7gm4hXEgLdQN4U7DQDZAGsb5fpFt1NhZCR03t2ItVvXXSMo37pXtrEdPyywyyq1OtVPaQ4EihZB5rFn6vNr3cZB7b9PQakWfIliDZBTnu", oauth_expires_at: "2015-01-04 19:18:00"}
])

Topic.create!([
  {user_id: 1, category_id: 1, title: "There should be no minimum wage."},
  {user_id: 1, category_id: 5, title: "Religion does not cause wars."},
  {user_id: 1, category_id: 1, title: "All drugs should be legalized."},
  {user_id: 1, category_id: 11, title: "You should sell AAPL stock."},
  {user_id: 1, category_id: 3, title: "Facebook is good for the world."},
  {user_id: 1, category_id: nil, title: "Euthanizing (assisted suicide) should be legalized. "}
])

Comment.create!([
  {content: "\"War\" preceded homo sapiens, and definitely preceded organized religion.\r\n\r\nBut the origin of any particular war seems to be the same as the pre-historic wars.  Wars seem to have two main causes:\r\n\r\n1. Control over resources.\r\n2. Control over people (political power).\r\n\r\nI find that if you look at current conflicts, religion is simply used by one (or more) of the ruling parties to justify the control over resources or people.", topic_id: 4, user_id: 1, is_agree: true, reply_to: 0},
  {content: "*From a political perspective:*\r\n\r\nLet's assume the government has two main roles:\r\n\r\n1. Protect people's liberties to the extent that they don't impede on another person's liberties. \r\n2. Evaluate & deter negative externalities (people acting in their own interest that is not overall optimal for society)\r\n\r\nIn this case, any citizen should have the free-will to choose whether to take drugs. \r\n\r\n*From a crime perspective:*\r\nMost crime is centered around black-markets for drugs. If you legalize the drugs, then the black-markets go away. There is plenty of evidence for this throughout history. \r\n\r\n*From an economic perspective:*\r\nTax revenue. ", topic_id: 5, user_id: 1, is_agree: true, reply_to: 0},
  {content: "Ever heard of the [Opium wars](http://en.wikipedia.org/wiki/First_Opium_War)?\r\n\r\nSometimes societies destroy themselves.  While I personally don't want a government regulating my life, I do see the overall benefit of not having easy access to highly addictive drugs. ", topic_id: 5, user_id: 1, is_agree: false, reply_to: 0},
  {content: "The rationale behind the \"Paleo\" diet is that we currently eat foods that humans are not evolved to eat. \r\n\r\nMore specifically, that during the Paleolithic period humans had a particular diet, and we have not evolved since then.\r\n\r\nSaying that something is bad for you while simultaneously saying that people are not evolving, is contradictory.\r\n\r\nIf something is bad for an organism, it exerts an evolutionary pressure on that organism. \r\n\r\nI do believe we may be less evolutionary fit for eating particular foods. For instance, I'm particularly bad at digesting cyanide. However saying that people are bad at digesting grains, yet people have not evolved to handle to handle grain consumption, is not plausible for me - at least without real evidence.", topic_id: 6, user_id: 1, is_agree: true, reply_to: 0},
  {content: "Look at the comments on \"Humans of New York\", it's a ton of people realizing that parents in Iraq, Palestine, Israel, Norway, Spain all say exactly the same thing.\r\n\r\nhttps://www.facebook.com/humansofnewyork", topic_id: 9, user_id: 1, is_agree: true, reply_to: 0},
  {content: "If you think that \"group think\" can apply on a macro-level... then now there is suddenly a very powerful, and potentially very dangerous medium for spreading mass hate. \r\n\r\nAlthough there hasn't been any occurrence of this type of thing happening on FB, it could potentially be scary.", topic_id: 9, user_id: 1, is_agree: false, reply_to: 0},
  {content: "[Eleven countries studied, one inescapable conclusion – the drug laws don’t work. Eight month study shows legalisation policies do not result in wider use, and the US should be watched with interest](http://www.theguardian.com/society/2014/oct/30/drug-laws-international-study-tough-policy-use-problem)", topic_id: 5, user_id: 1, is_agree: true, reply_to: 0},
  {content: "You have more energy when you do it! ", topic_id: 10, user_id: 1, is_agree: true, reply_to: 0},
  {content: "At low incomes, saving and investing in yourself to increase your wage is impossible. \r\n\r\n“I try to save up a little bit, but sometimes, I buy one thing and it’s all gone,” Barnett says.\r\n\r\nBy the time you've made enough money to sustain yourself, you are out of time, energy, and capital.   If you increase the minimum wage, you give very low-income people a chance to invest and raise their wage. \r\n\r\n[$10 an hour with no way out](http://america.aljazeera.com/articles/2014/2/4/-10-an-hour-withnowayout.html)\r\n\r\nAn economic theory called \"Solow's growth model\" reminds me of this. Solow's growth model says that there are \"steady states\" where low-income countries cannot advance to a high-income state, because they lack the resources to invest in themselves.  This seems very similar to people who are at a low-income state.", topic_id: 1, user_id: 1, is_agree: false, reply_to: 0}
])

Category.create!([
  {name: "economics", description: nil},
  {name: "public-policy", description: nil},
  {name: "start-ups", description: nil},
  {name: "business", description: nil},
  {name: "religion", description: nil},
  {name: "philosophy", description: nil},
  {name: "sociology", description: nil},
  {name: "politcs", description: nil},
  {name: "diet", description: nil},
  {name: "finance", description: nil},
  {name: "stocks", description: nil},
  {name: "health", description: nil},
  {name: "travel", description: nil},
  {name: "Medical Care", description: nil}
])

# These are incorrect.
TopicCategory.create!([
  {topic_id: 1, category_id: 1},
  {topic_id: 1, category_id: 2},
  {topic_id: 2, category_id: 3},
  {topic_id: 2, category_id: 4},
  {topic_id: 3, category_id: 5},
  {topic_id: 3, category_id: 6},
  {topic_id: 3, category_id: 7},
  {topic_id: 4, category_id: 5},
  {topic_id: 4, category_id: 6},
  {topic_id: 4, category_id: 7},
  {topic_id: 5, category_id: 2},
  {topic_id: 5, category_id: 8},
  {topic_id: 5, category_id: 1},
  {topic_id: 6, category_id: 9},
  {topic_id: 7, category_id: 10},
  {topic_id: 8, category_id: 11},
  {topic_id: 9, category_id: 7},
  {topic_id: 10, category_id: 12},
  {topic_id: 10, category_id: 13},
  {topic_id: 11, category_id: 14},
  {topic_id: 11, category_id: 8}
])

