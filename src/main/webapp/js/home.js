
// SEARCH FUNCTIONALITY

const searchInput =
document.getElementById("searchInput");

const restaurantCards =
document.querySelectorAll(".restaurant-card");

searchInput.addEventListener("keyup", () => {

    // USER INPUT

    const searchValue =
    searchInput.value.toLowerCase();

    // LOOP THROUGH CARDS

    restaurantCards.forEach((card) => {

        // GET RESTAURANT NAME

        const restaurantName =
        card.getAttribute("data-name");

        // MATCH CHECK

        if(restaurantName.includes(searchValue)){

            card.parentElement.style.display = "block";

        }
        else{

            card.parentElement.style.display = "none";
        }

    });

});

