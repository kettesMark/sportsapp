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
    end

    describe  "Check 'Outcomes page' after getting there via Sports index>Events page>Outcomes page" do
        it "click first 'Show outcomes' link on Events page then check outcomes table" do
            visit('http://localhost:3000/')
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
end
