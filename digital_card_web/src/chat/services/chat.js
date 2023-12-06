const socket = io("http://localhost:3000/");
const chatbox = document.getElementById("chatbox");
const btnSend = document.getElementById("btnSend");
const txaMessage = document.getElementById("txaMessage");

let page = 1;
let messages = [];
let tempMessages = [];
let hasMoreMessages = true;

function scrollToBottom() {
    chatbox.scrollTop = chatbox.scrollHeight;
}

getMessages();

socket.on("SendMessage", (data) => {
    if (data["Employee"]["Dni"] !== "00000000")
        chatbox.innerHTML += createComponentChatIncoming(data["Content"], data["Employee"])
    scrollToBottom();
});


function createComponentChatIncoming(content, employee) {
    return `
            <li class="chat incoming" id="chatincoming">
                <i class='bx bxs-user-circle'></i>
                <p>
                <b>${employee["Names"]} ${employee["Lastname"]}</b>:
                <br>${content}</p>
            </li>`
}

function createComponentChatOutgoing(content) {
    return `
            <li class="chat outgoing">
                <p>${content}</p>
            </li>
    `
}

btnSend.addEventListener("click", (e) => {
    let content = txaMessage.value.trim();
    chatbox.innerHTML += createComponentChatOutgoing(content);
    txaMessage.value = "";
    socket.emit("SendMessage", ({ "EmployeeDni": "00000000", "Content": content }))
});

async function getMessages() {
    let response = await axios.get(`${apiurl}/messages?page=${page}`);
    messages = await response.data;
    if (messages.length < 10)
        hasMoreMessages = false
    tempMessages = [...messages.reverse(), ...tempMessages]
    loadMessages();
    if (page === 1) {
        scrollToBottom()
    }

}

function loadMessages() {
    chatbox.innerHTML = "";
    for (let message of tempMessages) {
        if (message["Employee"]["Dni"] !== "00000000") {
            chatbox.innerHTML += createComponentChatIncoming(message["Content"], message["Employee"]);
        } else {
            chatbox.innerHTML += createComponentChatOutgoing(message["Content"]);
        }
    }
}

chatbox.addEventListener("scroll", (e) => {
    if (chatbox.scrollTop === 0 && hasMoreMessages) {
        ++page;
        getMessages();
    }
});