<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
          <!-- Shopping2-only Neo Hero: Glassmorphism + Spotlight crossfade + thumbnail marquee -->
        <section class="neo-hero text-white">
            <div class="container py-5">
                <div class="row align-items-center g-4">
                    <div class="col-lg-5">
                        <div class="glass p-4 p-lg-5">
                            <h1 class="mb-3">
                                <c:if test="${id_category==null}">Best categories & <br>products in our store</c:if>
                                <c:if test="${id_category!=null}">
                                    <c:forEach items="${listCategory}" var="category">
                                        <c:if test="${category.id == id_category}">Best ${category.name} <br>in our store</c:if>
                                    </c:forEach>
                                </c:if>
                            </h1>
                            <p class="mb-4">Trendy Products, Factory Prices, Excellent Service</p>
                            <div class="d-flex gap-3 flex-wrap">
                                <a href="#products" class="btn btn-light text-primary shadow-0">Purchase now</a>
                                <a href="#" class="btn btn-outline-light">Learn more</a>
                            </div>
                        </div>
                    </div>
                    <div class="col-lg-7">
                        <div class="spotlight position-relative">
                            <img id="spotA" class="spot-img show" src="" alt="spot"/>
                            <img id="spotB" class="spot-img" src="" alt="spot"/>
                        </div>
                    </div>
                </div>
            </div>

            <!-- Moving thumbnail marquee -->
            <div class="thumb-marquee">
                <div class="marquee-track" id="marqueeTrack"></div>
            </div>

            <!-- Data for spotlight slider (hidden) -->
            <div id="spotlight-data" style="display:none;">
                <c:forEach var="p" items="${listProduct}" varStatus="st3">
                    <c:if test="${p.status == true}">
                        <img data-src="assets/images/${p.image}" data-name="${p.name}" data-cat="${p.id_category}"/>
                    </c:if>
                </c:forEach>
            </div>
        </section>

        <style>
            .neo-hero { position: relative; overflow: hidden; background: linear-gradient(135deg,#0d6efd 0%,#6f42c1 55%,#0dcaf0 100%); }
            .neo-hero:before, .neo-hero:after { content: ""; position: absolute; border-radius: 50%; filter: blur(60px); opacity: .25; }
            .neo-hero:before { width: 420px; height: 420px; left: -120px; top: -120px; background: #ffffff; }
            .neo-hero:after  { width: 360px; height: 360px; right: -140px; bottom: -140px; background: #ffd966; }

            .glass { background: rgba(255,255,255,.12); border: 1px solid rgba(255,255,255,.35); border-radius: 18px; backdrop-filter: blur(10px); box-shadow: 0 10px 30px rgba(0,0,0,.15); }

            .spotlight { height: 380px; border-radius: 18px; overflow: hidden; box-shadow: 0 20px 40px rgba(0,0,0,.25); }
            @media (min-width: 992px) { .spotlight { height: 460px; } }
            .spot-img { position: absolute; inset: 0; width: 100%; height: 100%; object-fit: cover; opacity: 0; transform: scale(1); transition: opacity .9s ease, transform 2.8s ease; filter: saturate(1.1) contrast(1.05); }
            .spot-img.show { opacity: 1; transform: scale(1.07); }

            .thumb-marquee { position: relative; overflow: hidden; padding: 18px 0 26px; }
            .marquee-track { display: flex; align-items: center; gap: 20px; width: max-content; animation: marquee-move 30s linear infinite; }
            @keyframes marquee-move { from { transform: translateX(0); } to { transform: translateX(-50%); } }
            .thumb { width: 110px; height: 110px; border-radius: 14px; overflow: hidden; background: rgba(255,255,255,.16); border: 1px solid rgba(255,255,255,.28); box-shadow: 0 8px 18px rgba(0,0,0,.2); }
            .thumb img { width: 100%; height: 100%; object-fit: cover; }
            .thumb.active { outline: 2px solid #fff; box-shadow: 0 0 0 3px rgba(255,255,255,.35), 0 8px 18px rgba(0,0,0,.25); }
            @media (max-width: 576px) { .thumb { width: 86px; height: 86px; } }
        </style>

        <script>
        document.addEventListener('DOMContentLoaded', function(){
            var dataEls = Array.prototype.slice.call(document.querySelectorAll('#spotlight-data img'));
            var byCat = {};
            dataEls.forEach(function(el){
                var src = el.getAttribute('data-src');
                var cat = el.getAttribute('data-cat') || 'other';
                if (!src) return;
                if (!byCat[cat]) byCat[cat] = [];
                byCat[cat].push({ src: src });
            });
            var catIds = Object.keys(byCat);
            if (catIds.length === 0) return;

            // Build a round-robin sequence across categories for variety
            var seq = [];
            var pointers = {}; catIds.forEach(function(c){ pointers[c] = 0; });
            var targetLen = Math.min(16, dataEls.length); // up to 16 slides
            while (seq.length < targetLen) {
                var progressed = false;
                for (var i = 0; i < catIds.length && seq.length < targetLen; i++) {
                    var c = catIds[i]; var arr = byCat[c]; var p = pointers[c];
                    if (arr && p < arr.length) { seq.push(arr[p]); pointers[c] = p + 1; progressed = true; }
                }
                if (!progressed) break; // all exhausted
            }
            if (seq.length === 0) return;

            var a = document.getElementById('spotA');
            var b = document.getElementById('spotB');
            var marquee = document.getElementById('marqueeTrack');
            var useA = true; var stepIndex = 0; var timer = null;

            // Build thumbnails from the same sequence and duplicate once for seamless movement
            var thumbItems = seq.concat(seq);
            var thumbEls = [];
            if (marquee) {
                thumbItems.forEach(function(item, i){
                    var d = document.createElement('div'); d.className = 'thumb';
                    var img = document.createElement('img'); img.src = item.src; d.appendChild(img);
                    d.addEventListener('click', function(){ stepIndex = i; render(stepIndex); });
                    marquee.appendChild(d); thumbEls.push(d);
                });
            }

            function render(i){
                if (!seq || seq.length === 0) return;
                var logical = i % seq.length;
                var nextSrc = seq[logical].src;
                if (useA) { b.src = nextSrc; b.classList.add('show'); a.classList.remove('show'); }
                else { a.src = nextSrc; a.classList.add('show'); b.classList.remove('show'); }
                useA = !useA;
            }

            // Start slider
            if (seq && seq.length) {
                // Set initial image
                a.src = seq[0].src; a.classList.add('show');
                timer = setInterval(function(){ stepIndex = (stepIndex + 1) % (thumbItems.length); render(stepIndex); }, 3500);
            }
        });
        </script>









