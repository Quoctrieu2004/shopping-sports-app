<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>

<!-- Dynamic Products Display from Database -->
<c:choose>
    <c:when test="${not empty id_category}">
        <!-- Display products by selected category (split: new vs old) -->
        <c:forEach var="category" items="${listCategory}">
            <c:if test="${category.id == id_category}">
                <section class="mb-5">
                    <div class="container my-5">
                        <header class="mb-4">
                            <h3>${category.name}</h3>
                            <a href="home" class="btn btn-outline-primary">Xem Tất Cả Danh Mục</a>
                        </header>
                        <!-- New products -->
                        <h5 class="mb-3">Sản phẩm mới</h5>
                        <div class="row">
                            <c:forEach var="product" items="${newProducts}">
                                <c:if test="${product.id_category == category.id}">
                                    <div class="col-lg-3 col-md-6 d-flex">
                                        <div class="card w-100 my-2 shadow-2-strong">
                                            <img src="assets/images/${product.image}" class="card-img-top" style="aspect-ratio: 1/1"/>
                                            <div class="card-body d-flex flex-column">
                                                <h5 class="card-type">${product.name}</h5>
                                                <p class="card-text">${product.price} VND</p>
                                                <!-- Stock status like test2 -->
                                                <div class="mb-2">
                                                    <c:choose>
                                                        <c:when test="${product.status == true}">
                                                            <span class="badge bg-success">Còn hàng</span>
                                                        </c:when>
                                                        <c:otherwise>
                                                            <span class="badge bg-danger">Hết hàng</span>
                                                        </c:otherwise>
                                                    </c:choose>
                                                    <small class="text-muted ms-2">Số lượng: ${product.quantity}</small>
                                                </div>
                                                <div class="card-footer d-flex align-items-end pt-3 px-0 pb-0 mt-auto">
                                                    <c:choose>
                                                        <c:when test="${product.status == true}">
                                                            <c:if test="${user==null}">
                                                                <a href="login" class="btn btn-primary shadow-0 me-1">Thêm vào giỏ</a>
                                                            </c:if>
                                                            <c:if test="${user!=null}">
                                                                <a href="cart?action=add&id_product=${product.id}" class="btn btn-primary shadow-0 me-1">Thêm vào giỏ</a>
                                                            </c:if>
                                                        </c:when>
                                                        <c:otherwise>
                                                            <button class="btn btn-secondary shadow-0 me-1" disabled>Hết hàng</button>
                                                        </c:otherwise>
                                                    </c:choose>
                                                    <a href="#!" class="btn btn-light border px-2 pt-2 icon-hover">
                                                        <img src="./assets/icon/heart.png" width="20">
                                                    </a>
                                                </div>
                                            </div>
                                        </div>
                                    </div>
                                </c:if>
                            </c:forEach>
                        </div>
                        <!-- Old products -->
                        <h5 class="mt-4 mb-3">Sản phẩm cũ</h5>
                        <div class="row">
                            <c:forEach var="product" items="${oldProducts}">
                                <c:if test="${product.id_category == category.id}">
                                    <div class="col-lg-3 col-md-6 d-flex">
                                        <div class="card w-100 my-2 shadow-2-strong">
                                            <img src="assets/images/${product.image}" class="card-img-top" style="aspect-ratio: 1/1"/>
                                            <div class="card-body d-flex flex-column">
                                                <h5 class="card-type">${product.name}</h5>
                                                <p class="card-text">${product.price} VND</p>
                                                <!-- Stock status like test2 -->
                                                <div class="mb-2">
                                                    <c:choose>
                                                        <c:when test="${product.status == true}">
                                                            <span class="badge bg-success">Còn hàng</span>
                                                        </c:when>
                                                        <c:otherwise>
                                                            <span class="badge bg-danger">Hết hàng</span>
                                                        </c:otherwise>
                                                    </c:choose>
                                                    <small class="text-muted ms-2">Số lượng: ${product.quantity}</small>
                                                </div>
                                                <div class="card-footer d-flex align-items-end pt-3 px-0 pb-0 mt-auto">
                                                    <c:choose>
                                                        <c:when test="${product.status == true}">
                                                            <c:if test="${user==null}">
                                                                <a href="login" class="btn btn-primary shadow-0 me-1">Thêm vào giỏ</a>
                                                            </c:if>
                                                            <c:if test="${user!=null}">
                                                                <a href="cart?action=add&id_product=${product.id}" class="btn btn-primary shadow-0 me-1">Thêm vào giỏ</a>
                                                            </c:if>
                                                        </c:when>
                                                        <c:otherwise>
                                                            <button class="btn btn-secondary shadow-0 me-1" disabled>Hết hàng</button>
                                                        </c:otherwise>
                                                    </c:choose>
                                                    <a href="#!" class="btn btn-light border px-2 pt-2 icon-hover">
                                                        <img src="./assets/icon/heart.png" width="20">
                                                    </a>
                                                </div>
                                            </div>
                                        </div>
                                    </div>
                                </c:if>
                            </c:forEach>
                        </div>
                    </div>
                </section>
            </c:if>
        </c:forEach>
    </c:when>
    <c:otherwise>
        <!-- Home: Show products by category like test2 (limit 4 items per category, no stock badges) -->
        <c:forEach var="category" items="${listCategory}">
            <section class="mb-5">
                <div class="container my-5">
                    <header class="mb-4">
                        <h3>${category.name}</h3>
                        <a href="home?id_category=${category.id}" class="btn btn-outline-primary">Xem Tất Cả</a>
                    </header>
                    <div class="row">
                        <c:forEach var="product" items="${listProduct}">
                            <c:if test="${category.id == product.id_category && product.status == true}">
                                <div class="col-lg-3 col-md-6 d-flex">
                                    <div class="card w-100 my-2 shadow-2-strong">
                                        <img src="assets/images/${product.image}" class="card-img-top" style="aspect-ratio: 1/1"/>
                                        <div class="card-body d-flex flex-column">
                                            <h5 class="card-type">${product.name}</h5>
                                            <p class="card-text">${product.price} VND</p>
                                            <div class="card-footer d-flex align-items-end pt-3 px-0 pb-0 mt-auto">
                                                <c:if test="${user==null}">
                                                    <a href="login" class="btn btn-primary shadow-0 me-1">Thêm vào giỏ</a>
                                                </c:if>
                                                <c:if test="${user!=null}">
                                                    <a href="cart?action=add&id_product=${product.id}" class="btn btn-primary shadow-0 me-1">Thêm vào giỏ</a>
                                                </c:if>
                                                <a href="#!" class="btn btn-light border px-2 pt-2 icon-hover">
                                                    <img src="./assets/icon/heart.png" width="20">
                                                </a>
                                            </div>
                                        </div>
                                    </div>
                                </div>
                            </c:if>
                        </c:forEach>
                    </div>
                </div>
            </section>
        </c:forEach>
    </c:otherwise>
</c:choose>

<style>
.badge { font-size: 0.75rem; padding: 0.25rem 0.5rem; border-radius: 0.375rem; }
.bg-success { background-color: #28a745 !important; color: #fff; }
.bg-danger { background-color: #dc3545 !important; color: #fff; }
.text-muted { color: #6c757d !important; }
.ms-2 { margin-left: 0.5rem !important; }
.mb-2 { margin-bottom: 0.5rem !important; }
</style>

<!-- Simple Chatbot (copied from test2) -->
<div class="chat-widget" id="chatWidget">
    <div class="chat-header" onclick="toggleChat()">
        <i class="fas fa-comments me-2"></i>
        <span>Hỗ trợ tìm kiếm</span>
        <i class="fas fa-chevron-down ms-auto" id="chatToggleIcon"></i>
    </div>
    
    <div class="chat-body" id="chatBody" style="display: none;">
        <div class="chat-messages" id="chatMessages">
            <div class="message bot-message">
                <div class="message-content">
                    <strong>Bot:</strong> Xin chào! Tôi có thể giúp bạn tìm kiếm sản phẩm thể thao.
                </div>
            </div>
        </div>
        
        <div class="chat-input">
            <input type="text" id="chatInput" placeholder="Gõ/Đọc tên sản phẩm..." onkeypress="handleChatKeyPress(event)" />
            <button onclick="startVoiceSearch()" class="voice-btn">
                <i class="fas fa-microphone"></i>
            </button>
        </div>
    </div>
</div>

<!-- Chatbot CSS (from test2) -->
<style>
.chat-widget { position: fixed; bottom: 20px; right: 20px; width: 350px; background: white; border-radius: 10px; box-shadow: 0 4px 20px rgba(0,0,0,0.15); z-index: 1000; }
.chat-header { background: linear-gradient(135deg, #667eea 0%, #764ba2 100%); color: white; padding: 15px 20px; border-radius: 10px 10px 0 0; cursor: pointer; display: flex; align-items: center; font-weight: 500; }
.chat-body { height: 400px; display: flex; flex-direction: column; }
.chat-messages { flex: 1; padding: 15px; overflow-y: auto; max-height: 300px; }
.message { margin-bottom: 15px; display: flex; flex-direction: column; }
.user-message { align-items: flex-end; }
.bot-message { align-items: flex-start; }
.message-content { padding: 10px 15px; border-radius: 18px; max-width: 80%; word-wrap: break-word; }
.user-message .message-content { background: linear-gradient(135deg, #667eea 0%, #764ba2 100%); color: white; }
.bot-message .message-content { background: #f8f9fa; color: #333; border: 1px solid #e9ecef; }
.chat-input { padding: 15px; border-top: 1px solid #e9ecef; display: flex; align-items: center; gap: 10px; }
.chat-input input { flex: 1; border-radius: 20px; border: 1px solid #dee2e6; padding: 10px 15px; }
.voice-btn { background: linear-gradient(135deg, #667eea 0%, #764ba2 100%); color: white; border: none; border-radius: 50%; width: 45px; height: 45px; display: flex; align-items: center; justify-content: center; cursor: pointer; transition: transform 0.2s; }
.voice-btn:hover { transform: scale(1.1); }
.product-list { margin-top: 10px; max-height: 200px; overflow-y: auto; border: 1px solid #e9ecef; border-radius: 8px; background: white; }
.product-item { padding: 8px 12px; border-bottom: 1px solid #f1f3f4; cursor: pointer; transition: background-color 0.2s; font-size: 14px; display: flex; align-items: center; gap: 10px; }
.product-item:hover { background-color: #f8f9fa; }
.product-item:last-child { border-bottom: none; }
.product-image { width: 50px; height: 50px; flex-shrink: 0; border-radius: 6px; overflow: hidden; border: 1px solid #e9ecef; }
.product-image img { width: 100%; height: 100%; object-fit: cover; }
.product-info { flex: 1; min-width: 0; }
.product-name { font-weight: 500; color: #333; margin-bottom: 2px; font-size: 13px; line-height: 1.3; }
.product-category { font-size: 11px; color: #666; margin-bottom: 2px; }
.product-price { font-size: 12px; color: #28a745; font-weight: 600; }
.voice-status { font-size: 12px; color: #666; margin-top: 5px; text-align: center; }
.recording { color: #dc3545; animation: pulse 1s infinite; }
@keyframes pulse { 0% { opacity: 1; } 50% { opacity: 0.5; } 100% { opacity: 1; } }
</style>

<!-- Chatbot JavaScript (from test2) -->
<script>
var chatOpen = false;
var recognition = null;
var isRecording = false;
// Pending suggestion context (when bot asks: "Bạn có muốn tôi gợi ý...?")
var pendingSuggestKeyword = null;

function initSpeechRecognition() {
    if ('webkitSpeechRecognition' in window || 'SpeechRecognition' in window) {
        recognition = new (window.SpeechRecognition || window.webkitSpeechRecognition)();
        recognition.continuous = false;
        recognition.interimResults = false;
        recognition.lang = 'vi-VN';
        recognition.onstart = function() { 
            isRecording = true; 
            updateVoiceStatus('Đang nghe...', true);
        };
        recognition.onresult = function(event) {
            var transcript = event.results[0][0].transcript;
            document.getElementById('chatInput').value = transcript;
            sendChatMessage();
        };
        recognition.onend = function() { 
            isRecording = false; 
            updateVoiceStatus('', false);
        };
        recognition.onerror = function(event) { 
            isRecording = false; 
            updateVoiceStatus('Lỗi: ' + (event && event.error ? event.error : 'không xác định'), false);
        };
    }
}

function startVoiceSearch() {
    if (recognition && !isRecording) { 
        recognition.start();
        setTimeout(function(){ updateVoiceStatus('Đang nghe...', true); }, 0);
    }
    else if (!recognition) alert('Trình duyệt không hỗ trợ tìm kiếm bằng giọng nói');
}

function toggleChat() {
    var chatBody = document.getElementById('chatBody');
    var chatToggleIcon = document.getElementById('chatToggleIcon');
    if (chatOpen) { chatBody.style.display = 'none'; chatToggleIcon.className = 'fas fa-chevron-up ms-auto'; }
    else { chatBody.style.display = 'flex'; chatToggleIcon.className = 'fas fa-chevron-down ms-auto'; }
    chatOpen = !chatOpen;
}

function sendMessage() { var input = document.getElementById('chatInput'); var message = input.value.trim(); if (message) { addChatMessage('user', message); var response = generateBotResponse(message); addChatMessage('bot', response.message, response.products); input.value = ''; }}
function sendChatMessage() { sendMessage(); }
function handleChatKeyPress(event) { if (event.key === 'Enter') { sendMessage(); } }

// Show/hide listening status like test2
function updateVoiceStatus(message, recording) {
    var statusDiv = document.getElementById('voiceStatus');
    if (!statusDiv) {
        statusDiv = document.createElement('div');
        statusDiv.id = 'voiceStatus';
        statusDiv.className = 'voice-status';
        var container = document.querySelector('.chat-input');
        if (container) container.appendChild(statusDiv);
    }
    statusDiv.textContent = message || '';
    if (recording) statusDiv.classList.add('recording'); else statusDiv.classList.remove('recording');
}

function addChatMessage(sender, message, products) {
    var chatMessages = document.getElementById('chatMessages');
    var messageDiv = document.createElement('div');
    messageDiv.className = 'message ' + sender + '-message';
    var senderText = sender === 'user' ? 'Bạn' : 'Bot';
    var content = '<div class="message-content"><strong>' + senderText + ':</strong> ' + message + '</div>';
    if (products && products.length > 0) {
        content += '<div class="product-list">';
        var categories = {};
        products.forEach(function(product) { if (!categories[product.category]) { categories[product.category] = []; } categories[product.category].push(product); });
        Object.keys(categories).forEach(function(category) {
            content += '<div style="margin-bottom: 15px;">';
            content += '<div style="font-weight: bold; color: #667eea; margin-bottom: 8px; font-size: 14px;">📱 Sản phẩm nhóm ' + category + ':</div>';
            categories[category].forEach(function(product) {
                var safeName = (product.name || '').replace(/'/g, "\\'");
                content += '<div class="product-item" onclick="selectProduct(\'' + product.id + '\', \'' + safeName + '\')">';
                content += '<div class="product-image">';
                content += '<img src="assets/images/' + product.image + '" alt="' + product.name + '" />';
                content += '</div>';
                content += '<div class="product-info">';
                content += '<div class="product-name">' + product.name + '</div>';
                content += '<div class="product-category">' + product.category + '</div>';
                content += '<div class="product-price">' + product.price + ' VND</div>';
                content += '</div>';
                content += '</div>';
            });
            content += '</div>';
        });
        content += '</div>';
    }
    messageDiv.innerHTML = content;
    chatMessages.appendChild(messageDiv);
    chatMessages.scrollTop = chatMessages.scrollHeight;
}

function selectProduct(productId, productName) {
    addChatMessage('user', 'Tôi chọn: ' + productName);
    fetch('home?action=getProductStatus&id=' + productId)
        .then(response => response.json())
        .then(data => {
            if (data && data.status !== undefined) {
                if (data.status === true) {
                    setTimeout(function() {
                        var inStockResponses = [
                            'Tuyệt vời! ' + productName + ' hiện đang có sẵn trong kho. Bạn có muốn tôi gợi ý thêm một vài lựa chọn tương tự không?',
                            'Chính xác! ' + productName + ' đang còn hàng. Đây là mẫu được nhiều khách hàng ưa chuộng!',
                            'Tốt quá! ' + productName + ' sẵn sàng để thêm vào giỏ. Tôi có vài gợi ý tương tự, bạn tham khảo nhé!'
                        ];
                        var msg = inStockResponses[Math.floor(Math.random() * inStockResponses.length)];
                        addChatMessage('bot', msg);
                        // Save suggestion context using first keyword of product name
                        pendingSuggestKeyword = (productName||'').split(' ')[0].toLowerCase();
                    }, 300);
                } else {
                    setTimeout(function() {
                        var outResponses = [
                            'Ôi không! ' + productName + ' hiện đang hết hàng rồi. Nhưng đừng lo, tôi có thể gợi ý vài sản phẩm tương tự rất ổn!',
                            'Tiếc quá! ' + productName + ' vừa mới hết hàng. Tôi sẽ gửi bạn vài lựa chọn thay thế nhé!',
                            'Xin lỗi bạn! ' + productName + ' đang tạm hết. Mình thử xem những mẫu gần giống khác nha!'
                        ];
                        var msg = outResponses[Math.floor(Math.random() * outResponses.length)];
                        addChatMessage('bot', msg);

                        // Gợi ý các lựa chọn tương tự còn hàng
                        var kw = (productName||'').split(' ')[0].toLowerCase();
                        fetch('home?action=getAllProducts')
                          .then(r=>r.json())
                          .then(function(all){
                              var list = (all.products||[]).filter(function(p){ return (p.name||'').toLowerCase().indexOf(kw)!==-1; }).slice(0,6);
                              if (list.length>0) addChatMessage('bot', 'Bạn có thể tham khảo các sản phẩm tương tự sau:', list);
                              else addChatMessage('bot', 'Mình chưa tìm thấy sản phẩm tương tự. Bạn thử tìm theo danh mục: áo, giày, túi, kính...');
                          })
                          .catch(function(){});
                        // No pending confirm needed here since we already send suggestions
                        pendingSuggestKeyword = null;
                    }, 300);
                }
            } else {
                setTimeout(function() {
                    addChatMessage('bot', 'Tôi đang kiểm tra thêm về ' + productName + '. Bạn có thể thử tìm sản phẩm tương tự trong khi chờ nhé.');
                }, 500);
            }
        })
        .catch(function() {
            setTimeout(function() {
                addChatMessage('bot', 'Xin lỗi, có lỗi khi kiểm tra ' + productName + '. Hãy thử lại sau nhé.');
            }, 500);
        });
}

function generateBotResponse(userInput) {
    var input = userInput.toLowerCase();
    var response = { message: '', products: [] };

    // Handle short confirmations to show pending suggestions
    var confirms = ['có','ok','okay','yes','dạ','uh','ừ','duoc','được'];
    if (confirms.indexOf(input.trim()) !== -1) {
        if (pendingSuggestKeyword) {
            var kw = pendingSuggestKeyword;
            fetch('home?action=getAllProducts')
                .then(r => r.json())
                .then(function(data){
                    var list = (data.products || []).filter(function(p){
                        return (p.name || '').toLowerCase().indexOf(kw) !== -1;
                    }).slice(0, 6);
                    if (list.length > 0) {
                        addChatMessage('bot', 'Bạn có thể tham khảo các sản phẩm tương tự sau:', list);
                    }
                    pendingSuggestKeyword = null;
                })
                .catch(function(){ pendingSuggestKeyword = null; });
            return response;
        }
    }

    // Show all products grouped by category
    if (input.indexOf('tất cả') !== -1 && (input.indexOf('sản phẩm') !== -1 || input.indexOf('sp') !== -1)) {
        response.message = 'Đây là tất cả sản phẩm chúng tôi có, được nhóm theo danh mục:';
        fetch('home?action=getAllProducts')
            .then(r => r.json())
            .then(function(data){
                if (data && data.products && data.products.length > 0) {
                    addChatMessage('bot', response.message, data.products);
                } else {
                    addChatMessage('bot', 'Không tìm thấy sản phẩm nào trong database.');
                }
            })
            .catch(function(){ addChatMessage('bot', 'Lỗi khi tải dữ liệu sản phẩm từ database.'); });
        return response;
    }


    var mappings = [
        { keys: ['áo', 'ao'],               id: 1, label: 'Áo thể thao' },
        { keys: ['giày', 'giay'],           id: 2, label: 'Giày thể thao' },
        { keys: ['kính', 'kinh'],           id: 3, label: 'Kính bơi / Kính thể thao' },
        { keys: ['mũ', 'mu', 'nón', 'non'], id: 4, label: 'Mũ / Nón' },
        { keys: ['quần', 'quan'],           id: 5, label: 'Quần thể thao' },
        { keys: ['túi', 'tui', 'balo'],     id: 6, label: 'Túi / Balo' }
    ];

    for (var i = 0; i < mappings.length; i++) {
        var m = mappings[i];
        for (var k = 0; k < m.keys.length; k++) {
            if (input.indexOf(m.keys[k]) !== -1) {
                response.message = 'Bạn đang tìm ' + m.label + '! Đây là các sản phẩm phù hợp:';
                fetch('home?action=getProductsByCategory&category=' + m.id)
                    .then(r => r.json())
                    .then(function(data){
                        if (data && data.products && data.products.length > 0) {
                            addChatMessage('bot', response.message, data.products);
                        } else {
                            addChatMessage('bot', 'Không tìm thấy sản phẩm trong danh mục này.');
                        }
                    })
                    .catch(function(){ addChatMessage('bot', 'Lỗi khi tải dữ liệu từ database.'); });
                return response;
            }
        }
    }

    // Greetings
    if (input.indexOf('xin chào') !== -1 || input.indexOf('hello') !== -1 || input.indexOf('hi') !== -1) {
        response.message = 'Xin chào! Bạn có thể thử: "tìm áo", "tìm giày", "tìm kính", "tìm mũ", "tìm quần", "tìm túi".';
        return response;
    }

    // Fallback: fuzzy search in all products by name
    response.message = 'Kết quả tìm kiếm cho: "' + userInput + '"';
    fetch('home?action=getAllProducts')
        .then(r => r.json())
        .then(function(data){
            if (data && data.products && data.products.length > 0) {
                var kw = input.trim();
                var matched = data.products.filter(function(p){ return p.name.toLowerCase().indexOf(kw) !== -1; });
                if (matched.length > 0) {
                    addChatMessage('bot', response.message, matched);
                } else {
                    addChatMessage('bot', 'Mình chưa tìm thấy sản phẩm phù hợp. Bạn thử dùng từ khóa ngắn hơn (vd: "túi", "giày", "áo").');
                }
            } else {
                addChatMessage('bot', 'Không tải được dữ liệu sản phẩm.');
            }
        })
        .catch(function(){ addChatMessage('bot', 'Có lỗi khi tìm kiếm.'); });
    return response;
}

document.addEventListener('DOMContentLoaded', function() { initSpeechRecognition(); });
</script>




