import axios from 'axios';

const API_BASE_URL = 'http://localhost:8080'; // Update with your backend URL

export const loginUser = async (email, password) => {
  try {
    const response = await axios.post(`${API_BASE_URL}/api/login`, { email, password });
    return response.data;
  } catch (error) {
    throw error;
  }
};

export const getName = async () => {
  try {
    const response = await axios.get(`${API_BASE_URL}/api/common/get-name`);
    return response.data;
  } catch (error) {
    throw error;
  }
};

export const registerUser = async (registerData) => {
  try {
    const response = await axios.post(`${API_BASE_URL}/api/register`, registerData);

    // redirect to dashboard if registration is successful
    if (response.status === 200) {
      window.location.href = '/';
      return response.data;
    }

  } catch (error) {
    throw error;
  }
};
