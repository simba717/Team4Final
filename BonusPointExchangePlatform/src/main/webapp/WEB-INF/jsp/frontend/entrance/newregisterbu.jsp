<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html >
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <meta http-equiv="X-UA-Compatible" content="ie=edge">
    <title>Sign Up Form by Colorlib^_^</title>

    <!-- Font Icon -->
    <link rel="stylesheet" href="fonts/material-icon/css/material-design-iconic-font.min.css">
    <link rel="stylesheet" href="vendor/nouislider/nouislider.min.css">

    <!-- Main css -->
    <link rel="stylesheet" href="css/style.css">
</head>
<body>

    <div class="main">

        <div class="container">
            <div class="signup-content">
                <div class="signup-img">
                    <img src="images/form-img.jpg" alt="">
                    <div class="signup-img-content">
                        <h2>Register now </h2>
                        <p>while seats are available !</p>
                    </div>
                </div>
                <div class="signup-form">
                    <form action="" method="POST" class="register-form" id="register-form">
                        <div class="form-row">
                            <div class="form-group">
                                <div class="form-input">
                                    <label for="account" class="required">帳號</label>
                                    <input type="text" name="account" id="account" />
                                </div>
                                <div class="form-input">
                                    <label for="password" class="required">密碼</label>
                                    <input type="text" name="password" id="password" />
                                </div>
                                <div class="form-input">
                                    <label for="name" class="required">姓名</label>
                                    <input type="text" name="name" id="name" />
                                </div>
                                <div class="form-input">
                                    <label for="email" class="required">信箱</label>
                                    <input type="text" name="email" id="email" />
                                </div>
                                <div class="form-input">
                                    <label for="phone" class="required">手機</label>
                                    <input type="text" name="phone" id="phone" />
                                </div>
                            </div>
                            <div class="form-group">
                                <!-- <div class="form-select">
                                    <div class="label-flex">
                                        <label for="meal_preference">meal preference</label>
                                        <a href="#" class="form-link">Lunch detail</a>
                                    </div>
                                    <div class="select-list">
                                        <select name="meal_preference" id="meal_preference">
                                            <option value="Vegetarian">Vegetarian</option>
                                            <option value="Kosher">Kosher</option>
                                            <option value="Asian Vegetarian">Asian Vegetarian</option>
                                        </select>
                                    </div>
                                </div> -->
                                <!-- <div class="form-radio">
                                    <div class="label-flex">
                                        <label for="payment">Payment Mode</label>
                                        <a href="#" class="form-link">Payment Detail</a>
                                    </div>
                                    <div class="form-radio-group">            
                                        <div class="form-radio-item">
                                            <input type="radio" name="payment" id="cash" checked>
                                            <label for="cash">Cash</label>
                                            <span class="check"></span>
                                        </div>
                                        <div class="form-radio-item">
                                            <input type="radio" name="payment" id="cheque">
                                            <label for="cheque">Cheque</label>
                                            <span class="check"></span>
                                        </div>
                                        <div class="form-radio-item">
                                            <input type="radio" name="payment" id="demand">
                                            <label for="demand">Demand Draf</label>
                                            <span class="check"></span>
                                        </div>
                                    </div>
                                </div> -->
                                <div class="form-input">
                                    <label for="birth" class="required">生日</label>
                                    <input type="date" name="birth" id="birth" />
                                </div>
                                <div class="form-input">
                                    <label for="blank_name">銀行代碼</label>
                                    <input type="text" name="blank_name" id="blank_name" value="808" readonly />
                                </div>
                                <div class="form-input">
                                    <label for="account_no" class="required">銀行帳號</label>
                                    <input type="text" name="account_no" id="account_no" />
                                </div>
                            </div>
                                 <div class="form-input">
                                <label for="file" class="required">頭貼上傳</label>
                                <input type="file" name="image" id="file" accept="image/*" />
                            </div>
                        </div>
                        <!-- <div class="donate-us">
                            <label>Donate us</label>
                            <div class="price_slider ui-slider ui-slider-horizontal">
                                <div id="slider-margin"></div>
                                <span class="donate-value" id="value-lower"></span>
                            </div>
                        </div> -->
                        <div class="form-submit">
                            <input type="submit" value="Submit" class="submit" id="submit" name="submit" />
                            <input type="submit" value="Reset" class="submit" id="reset" name="reset" />
                        </div>
                    </form>
                </div>
            </div>
        </div>

    </div>

    <!-- JS -->
    <script src="vendor/jquery/jquery.min.js"></script>
    <script src="vendor/nouislider/nouislider.min.js"></script>
    <script src="vendor/wnumb/wNumb.js"></script>
    <script src="vendor/jquery-validation/dist/jquery.validate.min.js"></script>
    <script src="vendor/jquery-validation/dist/additional-methods.min.js"></script>
    <script type="text/javascript">(function($) {

    	  $('#meal_preference').parent().append('<ul class="list-item" id="newmeal_preference" name="meal_preference"></ul>');
    	  $('#meal_preference option').each(function(){
    	      $('#newmeal_preference').append('<li value="' + $(this).val() + '">'+$(this).text()+'</li>');
    	  });
    	  $('#meal_preference').remove();
    	  $('#newmeal_preference').attr('id', 'meal_preference');
    	  $('#meal_preference li').first().addClass('init');
    	  $("#meal_preference").on("click", ".init", function() {
    	      $(this).closest("#meal_preference").children('li:not(.init)').toggle();
    	  });
    	  
    	  var allOptions = $("#meal_preference").children('li:not(.init)');
    	  $("#meal_preference").on("click", "li:not(.init)", function() {
    	      allOptions.removeClass('selected');
    	      $(this).addClass('selected');
    	      $("#meal_preference").children('.init').html($(this).html());
    	      allOptions.toggle();
    	  });

    	  var marginSlider = document.getElementById('slider-margin');
    	  if (marginSlider != undefined) {
    	      noUiSlider.create(marginSlider, {
    	            start: [500],
    	            step: 10,
    	            connect: [true, false],
    	            tooltips: [true],
    	            range: {
    	                'min': 0,
    	                'max': 1000
    	            },
    	            format: wNumb({
    	                decimals: 0,
    	                thousand: ',',
    	                prefix: '$ ',
    	            })
    	    });
    	  }
    	  $('#reset').on('click', function(){
    	      $('#register-form').reset();
    	  });

    	  $('#register-form').validate({
    	    rules : {
    	        account : {
    	            required: true,
    	        },
    	        password : {
    	            required: true,
    	        },
    	        name : {
    	            required: true
    	        },
    	        email : {
    	            required: true,
    	            email : true
    	        },
    	        phone : {
    	            required: true,
    	        }
    	        // account_no : {
    	        //     required: true,
    	        // }
    	    },
    	    onfocusout: function(element) {
    	        $(element).valid();
    	    },
    	});

    	    jQuery.extend(jQuery.validator.messages, {
    	        required: "",
    	        remote: "",
    	        email: "",
    	        url: "",
    	        date: "",
    	        dateISO: "",
    	        number: "",
    	        digits: "",
    	        creditcard: "",
    	        equalTo: ""
    	    });
    	})(jQuery);</script>
    
</body><!-- This templates was made by Colorlib (https://colorlib.com) -->
</html>