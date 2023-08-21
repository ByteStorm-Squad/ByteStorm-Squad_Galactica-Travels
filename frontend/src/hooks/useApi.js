// import { useQuery } from "react-query";
// import axios from "axios";

// const callApi = async (url, method, noAuth, body) => {

//   const { data } = await axios({
//     url: url,
//     method: method,
//     headers: {
//       Authorization: !noAuth && `Bearer ${localStorage.jwt}`
//     },
//     data: body
//   });
//   return data;
// };

// export default function useApi(url, method, noAuth, body, name = "call") {
//   return useQuery([name, url, method, noAuth, body], () => callApi(url, method, noAuth, body));
// }

import axios from 'axios';

const API_BASE_URL = 'http://localhost:8080'; // Update to your backend URL

export const getJourneyByID = async (journeyID) => {
  try {
    const response = await axios.post(`${API_BASE_URL}/api/booking/getJourneyByID`, { Journey_ID: journeyID });
    return response.data;
  } catch (error) {
    throw error;
  }
};

// Similarly, update functions for other API endpoints
