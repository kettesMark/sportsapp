import React from 'react';
import { useParams, useNavigate } from 'react-router-dom';
 
const withRouter = RoutedComponent => props => {
  const params = useParams();
  const navigate = useNavigate();
 
  return (
    <RoutedComponent
      {...props}
      params={params}
      navigate ={navigate}
    />
  );
};
 
export default withRouter;