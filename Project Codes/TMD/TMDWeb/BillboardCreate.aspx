<%@ Page Title="" Language="C#" MasterPageFile="~/Template.Master" AutoEventWireup="true" CodeFile="BillboardCreate.aspx.cs" Inherits="targeted_marketing_display.BillboardCreate" EnableViewState="true" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
    <style type="text/css">
        #ContentPlaceHolder1_btnBack, #ContentPlaceHolder1_btnSubmit {
            width: 140px;
        }
    </style>
    <script type="text/javascript">
       //google.maps.event.addDomListener(window, 'load', initialize);
       // function initialize() {
       //     var autocomplete = new google.maps.places.Autocomplete(document.getElementById('LocationTB'));
       //     google.maps.event.addListerner(autocomplete, 'place_changed', function () {
       //         var place = autocomplete.getPlace();
       //         var location = "<b>Address</b>:" + place.formatted_address + "<br/>";
       //         location += "<b>Latitude</b>:" + place.geometry.location.A + "<br/>";
       //         location += "<b>Longtitude</b>:" + place.geometry.location.F;
       //         document.getElementById('lblResult').innerHTML = location
       //     });
       // }
    </script>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <form runat="server">
        <div class="row">
            <div class="col-12">
                <h1 class="page-header">New Billboard</h1>
            </div>
        </div>

        <div class="row">
            <div class="col-12">
                <asp:Button ID="btnBack" class="btn btn-primary float-left" runat="server" Text="Back" onclick="btnBack_Billboard" causesValidation="false"/>

                <asp:Button ID="btnSubmit" class="btn btn-primary float-right" runat="server" Text="Create" OnClick="SubmitBtn_Click" />
            </div>
        </div>

        <br />

        <div class="row">
            <div class="col-12">
                <div id="map" style="height: 400px"></div>
            </div>
        </div>

        <script>
            mapboxgl.accessToken = 'pk.eyJ1IjoiY2hlZWVmYW5nIiwiYSI6ImNqeWdyd3ozeDAzejQzZGwzMjY0MzhzYzcifQ.BN7hdcRRbZT02s4h8QR-iw';

            var map = new mapboxgl.Map({
                container: 'map', // Container ID
                style: 'mapbox://styles/mapbox/streets-v11', // Map style to use
                center: [103.819839,1.352083], // Starting position [lng, lat]
                zoom: 12, // Starting zoom level
            });
            var marker = new mapboxgl.Marker() // initialize a new marker
                .setLngLat([-122.25948, 37.87221]) // Marker [lng, lat] coordinates
                .addTo(map); // Add the marker to the map
            var geocoder = new MapboxGeocoder({ // Initialize the geocoder
            accessToken: mapboxgl.accessToken, // Set the access token
            mapboxgl: mapboxgl, // Set the mapbox-gl instance
            marker: false, // Do not use the default marker style
            placeholder: 'Search for places',
            // bbox: [-122.30937, 37.84214, -122.23715, 37.89838], // Boundary for Berkeley
            //proximity: {
            //  longitude: -122.25948,
            //  latitude: 37.87221
            //} // Coordina
            });

            // Add the geocoder to the map
                    map.addControl(geocoder);
                    // After the map style has loaded on the page,
            // add a source layer and default styling for a single point
            map.on('load', function() {
              map.addSource('single-point', {
                type: 'geojson',
                data: {
                  type: 'FeatureCollection',
                  features: []
                }
              });

              map.addLayer({
                id: 'point',
                source: 'single-point',
                  type: 'circle',
                  paint: {
                      'circle-radius': 10,
                      'circle-color': '#448ee4'
                  }
              });

            // Listen for the `result` event from the Geocoder
            // `result` event is triggered when a user makes a selection
            //  Add a marker at the result's coordinates
            geocoder.on('result', function (e) {
                console.log(e);
                console.log(e.result.context["0"].text);

            var string = e.result.place_name,
                length = string.length,
                step = 50,
                array = [],
                i = 0,
                j;
            console.log(length);
            // j = string.lastIndexOf(" ", i + step);
            //run when i<address total length

            //find index of empty space after i+50;
            j = string.lastIndexOf(" ", i + step);
            console.log(j);
            //if cant find empty space after a certain index,return -1
            if (j === -1) {
                j = length;
            }
            //push value of addln1 first,then addln2
            array.push(string.slice(0, j));
            array.push(string.slice(j, length));


            if (array[1] == undefined) {
                array[1] = ' ';
            }
            console.log(array);
            var address = array[0];
            var address2 = array[1];
            var longtitude = e.result.geometry.coordinates[0];
            var latitude = e.result.geometry.coordinates[1];
            var pCode = e.result.context["0"].text;
            var City = e.result.context["3"].text;
            var Country = e.result.context["3"].short_code;
            var CapsCountry = Country.toUpperCase();
            console.log(e.result.geometry.coordinates);
            document.getElementById("BBLatitude").value = latitude;
            document.getElementById("BBLongtitude").value = longtitude;
            document.getElementById("BBPostalCode").value = pCode;
            document.getElementById("BBCity").value = City;
            document.getElementById("BBAddLn1").value = address;
            document.getElementById("BBAddLn2").value = address2;
            document.getElementById("BBCountry").value = CapsCountry;
            map.getSource('single-point').setData(e.result.geometry);
          });
        });
        </script>
            
        <div runat="server" class="alert alert-success" id="alertSuccess" visible="False" style="width: 100%; margin: 0px 0px 20px 0px">
            <strong>Success!</strong> New location is created.
        </div> 

        <div runat="server" class="alert alert-danger" id="alertWarning" visible="False" style="width: 100%; margin: 0px 0px 20px 0px">
            <strong>Error!</strong>
            <asp:Label ID="warningLocation" runat="server"></asp:Label>
            <button type="button" class="close" data-dismiss="alert" aria-label="Close">
                <span aria-hidden="true">&times;</span>
            </button>
        </div>

        <div runat="server" class="alert alert-danger" id="alertDanger" visible="False" style="width: 100%; margin: 0px 0px 20px 0px">
            <strong>Error!</strong>
            <asp:Label ID="dangerLocation" runat="server"></asp:Label>
            <button type="button" class="close" data-dismiss="alert" aria-label="Close">
                <span aria-hidden="true">&times;</span>
            </button>
        </div>

        <br />

        <div class="row">
            <div class="col-12 col-md-6">
                <div class="form-group">
                    <label>Billboard Code: </label>
                    <label style="color: red">*</label>
                    <asp:TextBox class="form-control" ID="BBLocationCode" placeholder="Enter billboard code" runat="server" ClientIDMode="Static" MaxLength="10"></asp:TextBox>&nbsp;
                    <asp:RequiredFieldValidator ID="rfvBillboardCode" runat="server" ControlToValidate="BBLocationCode" Display="Dynamic" ErrorMessage="Please enter a billboard code" ForeColor="Red"></asp:RequiredFieldValidator>
                </div>
            </div>  
        </div>

        <div class="row">
            <div class="col-12 col-md-6">
                <div class="form-group">
                    <label>Address Line 1: </label>
                    <label style="color: red">*</label>
                    &nbsp;
                <asp:TextBox class="form-control" ID="BBAddLn1" placeholder="Enter address line 1" runat="server" ClientIDMode="Static" MaxLength="50"></asp:TextBox>&nbsp;
                <asp:RequiredFieldValidator ID="rfvAddressLine1" runat="server" ControlToValidate="BBAddLn1" Display="Dynamic" ErrorMessage="Please enter an address" ForeColor="Red"></asp:RequiredFieldValidator>
                </div>
            </div>

            <div class="col-12 col-md-6">
                <div class="form-group">
                    <label>Address Line 2 (Optional): </label> 
                    <asp:TextBox class="form-control" ID="BBAddLn2" placeholder="Enter address line 2" runat="server" ClientIDMode="Static" MaxLength="50"></asp:TextBox>
                    &nbsp;
                </div>
            </div>
        </div>

        <div class="row">
            <div class="col-12 col-md-6">
                <div class="form-group">
                    <label>City: </label>
                    <label style="color: red">*</label>
                    <asp:TextBox class="form-control" ID="BBCity" placeholder="Enter city" runat="server" ClientIDMode="Static" MaxLength="20"></asp:TextBox>&nbsp;
                    <asp:RequiredFieldValidator ID="rfvCity" runat="server" ControlToValidate="BBCity" Display="Dynamic" ErrorMessage="Please enter a city" ForeColor="Red"></asp:RequiredFieldValidator>
                    <asp:RegularExpressionValidator ID="revCity" runat="server" ControlToValidate="BBCity" Display="Dynamic" ErrorMessage="Please enter a valid city" ValidationExpression="^[a-zA-Z]+(?:[\s-][a-zA-Z]+)*$" ForeColor="Red"></asp:RegularExpressionValidator>                
                </div>
            </div>

            <div class="col-12 col-md-6">
                <div class="form-group">
                    <label>Country: </label>
                    <label style="color: red">*</label>
                    <asp:DropDownList Class="form-control" ID="BBCountry" runat="server" ClientIDMode="Static"></asp:DropDownList>&nbsp;
                    <asp:RequiredFieldValidator ID="rfvCountry" runat="server" ControlToValidate="BBCountry" Display="Dynamic" InitialValue="0" ErrorMessage="Please select a country" ForeColor="Red"></asp:RequiredFieldValidator>
                </div>     
            </div>
        </div>


        <div class="row">
            <div class="col-12 col-md-6">
                <div class="form-group">
                    <label>Latitude: </label>
                    <label style="color: red">*</label>
                    <asp:TextBox class="form-control" ID="BBLatitude" placeholder="Enter latitude" runat="server" ClientIDMode="Static" MaxLength="50"></asp:TextBox>&nbsp;
                    <asp:RequiredFieldValidator ID="rfvLatitude" runat="server" ControlToValidate="BBLatitude" Display="Dynamic" ErrorMessage="Please enter a latitude" ForeColor="Red"></asp:RequiredFieldValidator>
                    <asp:RegularExpressionValidator ID="revLatitude" runat="server" ControlToValidate="BBLatitude" Display="Dynamic" ErrorMessage="Please enter a valid latitude" ValidationExpression="^(\-?\d+(\.\d+)?)" ForeColor="Red"></asp:RegularExpressionValidator>
                </div>
            </div>
            <div class="col-12 col-md-6">
                <div class="form-group">
                    <label>Longtitude: </label>
                    <label style="color: red">*</label>
                    <asp:TextBox class="form-control" ID="BBLongtitude" placeholder="Enter longtitude" runat="server" ClientIDMode="Static" MaxLength="50"></asp:TextBox>&nbsp;
                    <asp:RequiredFieldValidator ID="rfvLongitude" runat="server" ControlToValidate="BBLongtitude" Display="Dynamic" ErrorMessage="Please enter a longtitude" ForeColor="Red"></asp:RequiredFieldValidator>
                    <asp:RegularExpressionValidator ID="revLongtitude" runat="server" ControlToValidate="BBLongtitude" Display="Dynamic" ErrorMessage="Please enter a valid longtitude" ValidationExpression="^(\-?\d+(\.\d+)?)" ForeColor="Red"></asp:RegularExpressionValidator>                
                </div>
            </div>
        </div>
        
        <div class="row">
            <div class="col-12 col-md-6">
                <div class="form-group">
                    <label>Postal Code: </label>
                    <label style="color: red">*</label>
                    <asp:TextBox class="form-control" ID="BBPostalCode" placeholder="Enter postal code" runat="server" ClientIDMode="Static" MaxLength="12"></asp:TextBox>&nbsp;
                    <asp:RequiredFieldValidator ID="rfvPostalCode" runat="server" ControlToValidate="BBPostalCode" Display="Dynamic" ErrorMessage="Please enter a postal code" ForeColor="Red"></asp:RequiredFieldValidator>
                    <asp:RegularExpressionValidator ID="revPostalCode" runat="server" ControlToValidate="BBPostalCode" Display="Dynamic" ErrorMessage="Please enter a valid postal code" ValidationExpression="^\d+$" ForeColor="Red"></asp:RegularExpressionValidator>                            
                </div>
            </div>
        </div>

    </form>
</asp:Content>