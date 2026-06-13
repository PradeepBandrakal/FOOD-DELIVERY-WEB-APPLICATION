
// MENU SEARCH FUNCTIONALITY

const searchInput =
document.getElementById("searchInput");

const menuCards =
document.querySelectorAll(".menu-card");

// SEARCH EVENT

searchInput.addEventListener("keyup", () => {

    // USER INPUT

    const searchValue =
    searchInput.value.toLowerCase();

    // LOOP THROUGH CARDS

    menuCards.forEach((card) => {

        // GET VALUES

        const itemName =
        card.getAttribute("data-name");

        const itemDescription =
        card.getAttribute("data-description");

        // MATCH CHECK

        if(
            itemName.includes(searchValue)
            ||
            itemDescription.includes(searchValue)
        ){

            card.style.display = "block";
        }
        else{

            card.style.display = "none";
        }

    });

});

