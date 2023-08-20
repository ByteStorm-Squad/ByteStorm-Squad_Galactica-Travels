import axios from 'axios';

const API_BASE_URL = 'http://localhost:8080'; // Update with your backend URL

export const createEvent = async (eventData) => {
  try {
    const response = await axios.post(`${API_BASE_URL}/api/events`, eventData);
    return response.data;
  } catch (error) {
    throw error;
  }
};

export const getAllEvents = async () => {
  try {
    const response = await axios.get(`${API_BASE_URL}/api/events`);
    return response.data;
  } catch (error) {
    throw error;
  }
};

export const getEventByCode = async (code) => {
  try {
    const response = await axios.get(`${API_BASE_URL}/api/events/${code}`);
    return response.data;
  } catch (error) {
    throw error;
  }
};

export const updateEvent = async (code, eventData) => {
  try {
    const response = await axios.put(`${API_BASE_URL}/api/events/${code}`, eventData);
    return response.data;
  } catch (error) {
    throw error;
  }
};

export const deleteEvent = async (code) => {
  try {
    const response = await axios.delete(`${API_BASE_URL}/api/events/${code}`);
    return response.data;
  } catch (error) {
    throw error;
  }
};
