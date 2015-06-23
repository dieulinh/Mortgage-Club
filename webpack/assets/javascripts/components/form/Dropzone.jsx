var React = require('react/addons');

var Dropzone = React.createClass({
  getDefaultProps: function() {
    return {
      supportClick: true,
      multiple: false
    };
  },

  getInitialState: function() {
    return {
      isDragActive: false
    }
  },

  propTypes: {
    onDrop: React.PropTypes.func.isRequired,
    style: React.PropTypes.object,
    field: React.PropTypes.object, // variables corresponding to this upload box
    supportClick: React.PropTypes.bool,
    accept: React.PropTypes.string,
    multiple: React.PropTypes.bool,
    uploadUrl: React.PropTypes.string,
    orderNumber: React.PropTypes.number,
    tip: React.PropTypes.string,
    fileUrl: React.PropTypes.string
  },

  componentDidMount: function() {
    var hasValue = false;
    if (hasValue) {
      $(this.refs.box.getDOMNode()).css({color: "#000"});
    }

    this.setState({
      tip: this.props.tip || 'click to upload',
      dropzoneBox: this.refs.box.getDOMNode()
    });

    if (this.props.fileUrl) {
      $(this.refs.box.getDOMNode()).css({backgroundColor: "#6B98F2", color: "#000"});
    }

  },

  onDragLeave: function(e) {
    this.setState({
      isDragActive: false
    });
  },

  onDragOver: function(e) {
    e.preventDefault();
    e.dataTransfer.dropEffect = "copy";

    this.setState({
      isDragActive: true
    });
  },

  onDrop: function(e) {
    e.preventDefault();

    this.setState({
      isDragActive: false
    });

    var files;
    if (e.dataTransfer) {
      files = e.dataTransfer.files;
    } else if (e.target) {
      files = e.target.files;
    }

    var maxFiles = (this.props.multiple) ? files.length : 1;

    if (typeof files[0] !== 'undefined') {
      if (this.props.uploadUrl) {
        // prepare formData object
        var formData = new FormData();
        formData.append('file', files[0]);
        formData.append('order', this.props.orderNumber);

        // notify uploading
        $(this.refs.box.getDOMNode()).css({backgroundColor: "#81F79F", color: "#FF0000"});

        this.setState({ tip: 'Uploading ...' });

        $.ajax({
          url: this.props.uploadUrl,
          method: 'POST',
          enctype: 'multipart/form-data',
          data: formData,
          success: function(response) {

            // update tip after update
            this.setState({ tip: files[0].name });

            // tooltip chosen dropzone
            $(this.refs.box.getDOMNode()).tooltip({ title: files[0].name });

            // highltight chosen dropzone
            $(this.refs.box.getDOMNode()).css({backgroundColor: "#6B98F2", color: "#000"});

            console.log(response.message);
          }.bind(this),
          cache: false,
          contentType: false,
          processData: false,
          async: true,
          error: function(response, status, error) {
            alert(error);
            return;
          }
        });
      }

      if (this.props.onDrop) {
        this.props.onDrop(files, this.props.field);
      };
    }
  },

  onClick: function() {
    if (this.props.supportClick === true) {
      this.open();
    }
  },

  open: function() {
    this.refs.fileInput.getDOMNode().click();
  },

  render: function() {
    var className = 'col-xs-9 ';
    className += (this.props.className || 'dropzone');
    if (this.state.isDragActive) {
      className += 'active';
    };

    var style = this.props.style || {
      borderStyle: this.state.isDragActive ? 'solid' : 'dotted'
    };

    return (
      <div>
        <label className='col-xs-6'>
          <span className='h7 typeBold'>{this.props.field.label}</span>
        </label>
        <div className='col-xs-6'>
          <div className="row">
            <div ref='box' className={className} style={style} onClick={this.onClick} onDragLeave={this.onDragLeave}
              onDragOver={this.onDragOver} onDrop={this.onDrop}>
              <input style={{display: 'none'}} type="file" multiple={this.props.multiple} ref="fileInput"
                onChange={this.onDrop} accept={this.props.accept}>
              </input>
              <div className='tip'>
                {this.state.tip}
              </div>
            </div>
            <div className='action-icons'>
              <a href={this.props.fileUrl}><i className="iconDownload"></i></a>
            </div>
          </div>
        </div>
      </div>
    );
  }

});

module.exports = Dropzone;
