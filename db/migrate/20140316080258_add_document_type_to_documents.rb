class AddDocumentTypeToDocuments < ActiveRecord::Migration
  def change
    add_reference :documents, :document_type, index: true
  end
end
