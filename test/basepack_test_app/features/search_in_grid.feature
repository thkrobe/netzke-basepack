Feature: Search
  In order to value
  As a role
  I want feature

  @javascript
  Scenario: Search via Search window
    Given the following roles exist:
    | id | name       |
    | 1  | admin      |
    | 2  | superadmin |
    | 3  | client     |

    And the following users exist:
    | first_name | last_name | role_id |
    | Paul       | Bley      | 1       |
    | Dalai      | Lama      | 3       |
    | Taisha     | Abelar    | 2       |
    | Florinda   | Donner    | 1       |

    When I go to the UserGrid test page
    Then the grid should show 4 records

    When I press "Search"
    And I wait for response from server
    And I expand combobox "undefined_attr"
    And I select "First name" from combobox "undefined_attr"
    # And I wait for response from server
    And I fill in "first_name_value" with "ai"
    And I press "Search" within "#user_grid__search_window"
    And I wait for response from server
    Then the grid should show 2 records

  @javascript
  Scenario: Search via Search window by association
    Given the following roles exist:
    | id | name       |
    | 1  | admin      |
    | 2  | superadmin |
    | 3  | client     |

    And the following users exist:
    | first_name | last_name | role_id |
    | Paul       | Bley      | 1       |
    | Dalai      | Lama      | 3       |
    | Taisha     | Abelar    | 2       |
    | Florinda   | Donner    | 1       |

    When I go to the UserGrid test page

    When I press "Search"
    And I expand combobox "undefined_attr"
    And I select "Role name" from combobox "undefined_attr"
    And I fill in "role__name_value" with "adm"
    And I press "Search" within "#user_grid__search_window"
    And I wait for response from server
    Then the grid should show 3 records

    When I press "Search"
    And I fill in "role__name_value" with "client"
    And I press "Search" within "#user_grid__search_window"
    And I wait for response from server
    Then the grid should show 1 records

  # @javascript
  # Scenario: Search via Search window with OR conditions
    # When I press "Search"
    # And I press "+"
    # And I expand combobox "undefined_attr"
    # And I select "First name" from combobox "undefined_attr"
    # And I sleep 5 seconds
    # And I fill in "first_name_value" with "in"
    # And I press "Search" within "#user_grid__search_window"
    # And I wait for response from server
    # Then the grid should show 3 records
