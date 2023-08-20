import axios from 'axios';

const API_BASE_URL = 'http://localhost:8080'; // Update with your backend URL

export const createAttraction = async (attractionData) => {
  try {
    const response = await axios.post(`${API_BASE_URL}/api/attractions/create`, attractionData);
    return response.data;
  } catch (error) {
    throw error;
  }
};

export const getAllAttractions = async () => {
  try {
    const response = await axios.get(`${API_BASE_URL}/api/attractions`);
    return response.data;
  } catch (error) {
    throw error;
  }
};

export const getAttractionByCode = async (code) => {
  try {
    const response = await axios.get(`${API_BASE_URL}/api/attractions/${code}`);
    return response.data;
  } catch (error) {
    throw error;
  }
};

export const updateAttraction = async (code, attractionData) => {
  try {
    const response = await axios.put(`${API_BASE_URL}/api/attractions/${code}`, attractionData);
    return response.data;
  } catch (error) {
    throw error;
  }
};

export const deleteAttraction = async (code) => {
  try {
    const response = await axios.delete(`${API_BASE_URL}/api/attractions/${code}`);
    return response.data;
  } catch (error) {
    throw error;
  }
};
