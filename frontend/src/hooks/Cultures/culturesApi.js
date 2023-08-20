import axios from 'axios';

const API_BASE_URL = 'http://localhost:8080'; // Update with your backend URL

export const createCulture = async (cultureData) => {
  try {
    const response = await axios.post(`${API_BASE_URL}/api/cultures/create`, cultureData);
    return response.data;
  } catch (error) {
    throw error;
  }
};

export const getAllCultures = async () => {
  try {
    const response = await axios.get(`${API_BASE_URL}/api/cultures`);
    return response.data;
  } catch (error) {
    throw error;
  }
};

export const getCultureByCode = async (code) => {
  try {
    const response = await axios.get(`${API_BASE_URL}/api/cultures/${code}`);
    return response.data;
  } catch (error) {
    throw error;
  }
};

export const updateCulture = async (code, cultureData) => {
  try {
    const response = await axios.put(`${API_BASE_URL}/api/cultures/${code}`, cultureData);
    return response.data;
  } catch (error) {
    throw error;
  }
};

export const deleteCulture = async (code) => {
  try {
    const response = await axios.delete(`${API_BASE_URL}/api/cultures/${code}`);
    return response.data;
  } catch (error) {
    throw error;
  }
};
