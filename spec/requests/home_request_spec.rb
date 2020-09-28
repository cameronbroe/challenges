require 'rails_helper'

RSpec.describe "Homes", type: :request do
  describe "POST /upload" do
    let(:empty_file) { fixture_file_upload(file_fixture('empty_csv.csv')) }
    let(:bad_header_file) { fixture_file_upload(file_fixture('bad_header.csv')) }
    let(:missing_cell_file) { fixture_file_upload(file_fixture('missing_cell.csv')) }
    let(:valid_data_file) { fixture_file_upload(file_fixture('valid_data.csv')) }


    it "should error when an empty CSV is uploaded" do
      post upload_path, params: { file: empty_file }
      expect(response).to have_http_status(:ok)
      expect(response.content_type).to include('application/json')
      expect(response.parsed_body["status"]).to eq('error')
    end

    it "should error when a CSV with an invalid header is uploaded" do
      post upload_path, params: { file: bad_header_file }
      expect(response).to have_http_status(:ok)
      expect(response.content_type).to include('application/json')
      expect(response.parsed_body["status"]).to eq('error')
    end

    it "should error when a CSV with an empty cell is uploaded" do
      post upload_path, params: { file: missing_cell_file }
      expect(response).to have_http_status(:ok)
      expect(response.content_type).to include('application/json')
      expect(response.parsed_body["status"]).to eq('error')
    end

    it "should succeed when a well formatted CSV is uploaded" do
      post upload_path, params: { file: valid_data_file }
      expect(response).to have_http_status(:ok)
      expect(response.content_type).to include('application/json')
      expect(response.parsed_body["status"]).to eq('success')
    end
  end
end
