require 'rails_helper'

RSpec.describe 'Index page', type: :system do
    describe  "visit sports index and check table" do
        it 'has table' do
            visit('http://localhost:3000/')
            expect(page).to have_css 'table'
        end
    
        it 'table has the right columns' do
            visit('http://localhost:3000/')
            within 'table' do
               assert page.has_no_content?("<th>ID</th>")
               assert page.has_no_content?("<th>Description</th>")
               assert page.has_no_content?("<th>Events</th>")
            end
        end

        it 'Sports table has the right columns' do
            visit('http://localhost:3000/')
            get '/sports', as: :json
            response.parsed_body
            first_sport_desc = response.parsed_body[0]["desc"]
            res =find(:xpath, "//tr[td[contains(.,'#{first_sport_desc}')]]")
            assert res.present?
            last_sport_desc = response.parsed_body[-1]["desc"]
            res =find(:xpath, "//tr[td[contains(.,'#{last_sport_desc}')]]")
            assert res.present?
        end

        it "clicking 'Show events' in first row takes us to an events page" do
            visit('http://localhost:3000/')
            expect(page).to have_content('Show events')
            first(:link, "Show events").click
            sleep(2)
            expect(current_path).to have_content("events/")
            #expect(page).to have_content('Show outcomes')
        end
    end

    describe  "click first 'Show events' link on sports index and check Events page " do
        it "click 'Show events' on sports index then check events table" do
            visit('http://localhost:3000/')
            expect(page).to have_content('Show events')
            first(:link, "Show events").click
            sleep(2)
            expect(page).to have_css 'table'
            within 'table' do
                assert page.has_no_content?("<th>ID</th>")
                assert page.has_no_content?("<th>Competition</th>")
                assert page.has_no_content?("<th>Description</th>")
                assert page.has_no_content?("<th>Outcomes</th>")
             end
        end

        it "On Events page click first 'Show outcomes' link then check URL" do
            visit('http://localhost:3000/')
            expect(page).to have_content('Show events')
            first(:link, "Show events").click
            sleep(2)
            first(:link, "Show outcomes").click
            expect(current_path).to have_content("/outcomes/")
        end

        it 'Events table has the right columns' do
            visit('http://localhost:3000/')
            get '/sports', as: :json
            response.parsed_body
            find(:xpath, "//tr[td[contains(.,'#{response.parsed_body[0]['desc']}')]]/td/a", :text => 'Show events').click
            sleep(2)
            get "/sports/#{response.parsed_body[0]['id']}", as: :json
            first_event_desc = response.parsed_body[0]['desc']
            res =find(:xpath, "//tr[td[contains(.,'#{first_event_desc}')]]")
            assert res.present?
            first_event_comp_desc = response.parsed_body[0]["comp_desc"]
            res =find(:xpath, "//tr[td[contains(.,'#{first_event_comp_desc}')]]")
            assert res.present?
        end
    end

    describe  "Check 'Outcomes page' after getting there via Sports index>Events page>Outcomes page" do
        it "click first 'Show outcomes' link on Events page then check outcomes table" do
            visit('http://localhost:3000/')
            sleep(2)
            expect(page).to have_content('Show events')
            first(:link, "Show events").click
            sleep(2)
            first(:link, "Show outcomes").click
            expect(page).to have_css 'table'
            within 'table' do
                assert page.has_no_content?("<th>ID</th>")
                assert page.has_no_content?("<th>Fractional odds</th>")
                assert page.has_no_content?("<th>Decimal odds</th>")
             end
        end
    end

    it 'Outcomes table has the right columns' do
        visit('http://localhost:3000/')
        get '/sports', as: :json
        response.parsed_body
        sport_id = response.parsed_body[0]['id']
        find(:xpath, "//tr[td[contains(.,'#{response.parsed_body[0]['desc']}')]]/td/a", :text => 'Show events').click
        sleep(2)
        get "/sports/#{sport_id}", as: :json
        event_id = response.parsed_body[0]['id']
        find(:xpath, "//tr[td[contains(.,'#{response.parsed_body[0]['desc']}')]]/td/a", :text => 'Show outcomes').click
        sleep(2)
        get "/sports/#{sport_id}/events/#{event_id}", as: :json
        first_outcome_desc = response.parsed_body[0]['desc']
        res =find(:xpath, "//tr[td[contains(.,'#{first_outcome_desc}')]]")
        assert res.present?
        last_outcome_desc = response.parsed_body[-1]["desc"]
        res =find(:xpath, "//tr[td[contains(.,'#{last_outcome_desc}')]]")
        assert res.present?
    end

    describe  "Check 'Go back' buttons" do
        it "get to one of the Outcomes pages using 'Show...' buttons then go back to Sports page using the 'Go back' buttons" do
            visit('http://localhost:3000/')
            sleep(2)
            expect(page).to have_content('Show events')
            first(:link, "Show events").click
            sleep(2)
            first(:link, "Show outcomes").click
            expect(current_path).to have_content("/outcomes/")
            first(:button, "Go back").click
            expect(current_path).to have_content("/events")
            first(:button, "Go back").click
            expect(current_path).to have_content("/")
        end
    end
end
