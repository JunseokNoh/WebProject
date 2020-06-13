

(function(i,s,o,g,r,a,m){i['GoogleAnalyticsObject']=r;i[r]=i[r]||function(){
                (i[r].q=i[r].q||[]).push(arguments)},i[r].l=1*new Date();a=s.createElement(o),
            m=s.getElementsByTagName(o)[0];a.async=1;a.src=g;m.parentNode.insertBefore(a,m)
    })(window,document,'script','https://www.google-analytics.com/analytics.js','ga');
    ga('create', 'UA-40481198-1', 'auto');
    ga('send', 'pageview');
    
    function fnMove(value){
        var offset = $("#div" + value).offset();
        $('html, body').animate({scrollTop : offset.top - 50}, 0);
    }
    
    function backToTop(){
        $('html, body').animate({scrollTop : 0}, 2);
    }
    
    const keywords = ["포털 ", "음악 ", "영화 ", "도서 "];
    $(document).ready(function() {
        let i = 1;
        setInterval(function() {
            const newKeyword = keywords[i];
            $("#keyword").animate({ opacity: 0 }, function() {
                $(this).text(newKeyword).animate({ opacity: 1 });
            });
            if (i+1 === keywords.length) {
                i = 0;
            } else {
                i++;
            }
        }, 3500);
        
        $(window).scroll( function(){
            /* 2 */
            $('#backtoTop').each( function(){

            	 var bottom_of_element = $(this).offset().top + $(this).outerHeight();
                 var bottom_of_window = $(window).scrollTop() + $(window).height();
                 
                 if( bottom_of_window > bottom_of_element ){
                     $(this).animate({'opacity':'1','margin-left':'0px'},700);
                 }
            }); 
        });
    });