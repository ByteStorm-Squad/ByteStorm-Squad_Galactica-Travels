import axios from 'axios';

const API_BASE_URL = 'http://localhost:8080'; // Update with your backend URL

export const getJourneyByID = async (journeyID) => {
  try {
    const response = await axios.post(`${API_BASE_URL}/api/booking/getJourneyByID`, { Journey_ID: journeyID });
    return response.data;
  } catch (error) {
    throw error;
  }
};

export const getPodsByJourney = async (journeyID) => {
  try {
    const response = await axios.post(`${API_BASE_URL}/api/booking/getPodsbyJourney`, { Journey_ID: journeyID });
    return response.data;
  } catch (error) {
    throw error;
  }
};

export const createBooking = async (bookingData) => {
  try {
    const response = await axios.post(`${API_BASE_URL}/api/booking/createbooking`, bookingData);
    return response.data;
  } catch (error) {
    throw error;
  }
};

export const getNextFlights = async (passengerCount, route) => {
  try {
    const response = await axios.post(`${API_BASE_URL}/api/booking/getnextflights`, {
      passengerCount,
      route,
    });
    return response.data;
  } catch (error) {
    throw error;
  }
};

export const getLocations = async () => {
  try {
    const response = await axios.get(`${API_BASE_URL}/api/booking/getlocations`);
    console.log(response.data)
    return response.data;
  } catch (error) {
    throw error;
  }
};

export const deleteBooking = async () => {
  try {
    const response = await axios.delete(`${API_BASE_URL}/api/booking/deleteBookings`);
    return response.data;
  } catch (error) {
    throw error;
  }
};
