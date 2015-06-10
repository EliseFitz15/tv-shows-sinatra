require "spec_helper"

feature "user views list of TV shows" do
  # As a TV fanatic
  # I want to view a list of TV shows
  # So I can find new shows to watch
  #
  # Acceptance Criteria:
  # * I can see the names and networks of all TV shows

  scenario "view list of TV shows" do
    # First create some sample TV shows
    game_of_thrones = TelevisionShow.create!({
        title: "Game of Thrones", network: "HBO",
        starting_year: 2011, genre: "Fantasy"
      })

    married_with_children = TelevisionShow.create!({
        title: "Married... with Children", network: "Fox",
        starting_year: 1987, ending_year: 1997,
        genre: "Comedy"
      })

    # The user visits the index page
    visit "/television_shows"

    # And should see both TV shows listed (just the title and network)
    expect(page).to have_content("Game of Thrones (HBO)")
    expect(page).to have_content("Married... with Children (Fox)")
  end

  # As a TV fanatic
  # I want to view the details for a TV show
  # So I can find learn more about it

  # Acceptance Criteria:
  # * I can see the title, network, start and end year, genre, and synopsis
  #   for a show.
  # * If the end year is not provided it should indicate that the show is still
  #   running.

  scenario "view details for a TV show" do
    game_of_thrones = TelevisionShow.create!({
        title: "Game of Thrones", network: "HBO",
        starting_year: 2011, genre: "Fantasy"
      })

    married_with_children = TelevisionShow.create!({
        title: "Married... with Children", network: "Fox",
        starting_year: 1987, ending_year: 1997,
        genre: "Comedy"
      })
    visit '/television_shows'
    expect(page).to have_content("TV Shows")
    expect(page).to have_content("Game of Thrones (HBO)")
    click_link 'Game of Thrones'
    expect(page).to have_content("Game of Thrones")
    expect(page).to have_content("Genre")
  end

  scenario "view details for a TV show with missing information" do
    game_of_thrones = TelevisionShow.create!({
        title: "Game of Thrones", network: "HBO",
        starting_year: 2011, genre: "Fantasy"
      })

    married_with_children = TelevisionShow.create!({
        title: "Married... with Children", network: "Fox",
        starting_year: 1987, ending_year: 1997,
        genre: "Comedy"
      })
      visit "/television_shows"
      click_link "Game of Thrones"
      expect(page).to_not have_content("Synopsis")
  end

  scenario "edit details for a TV show" do
    orange_is_new = TelevisionShow.create!({
        title: "Orange is the New Black", network: "Netflix",
        starting_year: 2013,
        genre: "Drama"
      })
    visit "/"
    click_link "Orange is the New Black"
    expect(page).to have_content("Orange is the New Black")
    click_link "Edit TV Show Information"
    expect(page).to have_content("Edit TV Show")
    find_field('title').value
    fill_in "synopsis", with: "Lady in jail."
    click_button "Update TV Show"
    save_and_open_page
    expect(page).to have_content("Orange is the New Black")
    expect(page).to have_content("Network")
    expect(page).to have_content("Lady in jail.")

  end

end
