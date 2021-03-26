var scrap = {};

scrap['artist'] = function() {
    return {
        required: [
            "name",
            "groupyn",
            "gender",
            "genre",
            "img",
        ]
        , get: function() {
            return this.required.map( (v, i) => {
                return this[v];
            }).join("|");
        }
        , name : document.querySelector(".bagde_area .badge_track_info .artist").textContent.trim()
        , groupyn : (function() {
            var grouplabel = document.querySelector(".bagde_area .badge_track_info dl").getElementsByTagName("dd")[0].textContent.trim()
            if (grouplabel === "솔로")
                return "N";
            else if (grouplabel === "그룹") 
                return "Y";
            else
                return null;
        })()
        , gender : (function() {
            var genderLabel = document.querySelector(".bagde_area .badge_track_info dl").getElementsByTagName("dd")[1].textContent.trim();
            if (genderLabel === "남성") return "M";
            else if (genderLabel === "여성") return "F";
            else return "A";
        })()
        , genre : document.querySelector(".bagde_area .badge_track_info dl").getElementsByTagName("dd")[2].textContent.split(",")[0].trim()
        , img : (function() {
            var url = document.querySelector(".bagde_area .link_thumbnail").style.backgroundImage;
            url = url.substring(5, url.length - 2);
            return url;
        })()
    };
};

scrap['album'] = function() {
    return {
        required: [
            // "abseq",
            // "atseq",
            "title",
            "img",
            "content",
            "abtype",
            "gseq",
            "pdate", // YYYY.MM.dd
        ]
        , get: function() {
            return this.required.map( (v, i) => {
                return this[v];
            }).join("|");
        }
        , title: (function() {
            return document.querySelector(".badge_track_info .title").textContent.trim();
        })()
        , img : (function() {
            return document.querySelector(".link_thumbnail img").src;
        })()
        , content : (function() {
            try {
                return document.querySelector(".section_content_wrap .lyrics").textContent;   
            } catch (e) {
                return null;
            }
        })()
        , abtype : (function() {
            return document.querySelector(".badge_track_info dl").getElementsByTagName("dd")[0].textContent;
        })()
        , gseq : (function() {
            return document.querySelector(".badge_track_info dl").getElementsByTagName("dd")[1].textContent;
        })()
        , pdate : (function() {
            return document.querySelector(".badge_track_info dl").getElementsByTagName("dd")[2].innerText;
        })()
    };
};

scrap['music'] = function() {
    return {
        required: [
            // "mseq",
            // "abseq",
            // "atseq",
            "theme",
            "chart",
            "gseq",
            "title",
            "content",
            "titleyn",
            "musicby",
            "lyricsby",
            "producingby",
            // "src",
        ]
        , get: function() {
            return this.required.map( (v, i) => {
                return this[v];
            }).join("|");
        }
        , theme: (function() {
            return null;
        })()
        , chart: (function() {
            return null;
        })()
        , gseq: (function() {
            return null;
        })()
        , title: (function() {
            return document.querySelector(".badge_track_info .title").textContent.trim();
        })()
        , content: (function() {
            return document.querySelector(".lyrics").innerHTML;
        })()
        , titleyn: (function() {
            return null;
        })()
        , musicby: (function() {
            try {
                return document.querySelector(".ly_explain").getElementsByTagName("dd")[1].textContent;   
            } catch (e) {
               return null;
            }
            
        })()
        , lyricsby: (function() {
            try {
                return document.querySelector(".ly_explain").getElementsByTagName("dd")[2].textContent;   
            } catch (e) {
               return null;
            }
        })()
        , producingby: (function() {
            try {
                return document.querySelector(".ly_explain").getElementsByTagName("dd")[3].textContent;   
            } catch (e) {
               return null;
            }
        })()
    }
}
    
copy(scrap.artist().get());
copy(scrap.album().get());
copy(scrap.music().get());