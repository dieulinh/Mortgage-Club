class PropertyDocumentUploaderController < ApplicationController
  # TODO: refactor with other document uploaders
  def download
    return render json: { message: 'Invalid document type' } unless params[:type].present? && params[:id].present?
    document = params[:type].constantize.find(params[:id])
    url = Amazon::GetUrlService.new(document.attachment.s3_object).call
    redirect_to url
  end

  def upload
    return render json: { message: 'File not found' }, status: 500 if params[:file].blank?
    return render json: { message: 'Invalid document type' }, status: 500 unless params[:type].present?
    return render json: { message: 'Property not found' }, status: 500 if params[:property_id].blank?

    document_klass = params[:type].constantize
    document = document_klass.where(property_id: params[:property_id]).last
    property = Property.find(params[:property_id])

    if document.present?
      document.update(attachment: params[:file])
    else
      document = document_klass.new(attachment: params[:file], property: property)
      document.owner = current_user
      document.save
    end

    render json: { message: "Uploaded sucessfully" }, status: 200
  end

  def remove
    return render json: { message: 'Invalid document type' } unless params[:type].present? && params[:property_id].present?
    document_klass = params[:type].constantize
    document = document_klass.where(property_id: params[:property_id]).last
    document.destroy
    render json: { message: "Removed it sucessfully" }, status: 200
  end
end
