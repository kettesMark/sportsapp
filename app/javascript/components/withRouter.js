import React from 'react';
import { useParams } from 'react-router-dom';
 
const withRouter = RoutedComponent => props => {
  const params = useParams();
 
  return (
    <RoutedComponent
      {...props}
      params={params}
    />
  );
};
 
export default withRouter;