import { Table, message } from "antd";
import { Link } from "react-router-dom";
import React from "react";

class Sport extends React.Component {
  
  columns = [
    {
      title: "ID",
      dataIndex: "id",
      key: "id",
    },
    {
      title: "Description",
      dataIndex: "desc",
      key: "desc",
    },
    {
      title: "Events",
      dataIndex: "id",
      render: (id) => <Link to={`/events/${id}`} key={id}> {"Show events"} </Link>
    }
  ]

  state = {
    sports: [],
  };

  componentDidMount() {
    this.loadSports();
  }

  loadSports = () => {
      const sportsUrl = "/sports"
      fetch(sportsUrl)
      .then((data) => {
        if (data.ok) {
          return data.json();
        }
        throw new Error("Network error.");
      })
      .then((data) => {
          data.forEach((sport) =>{
              const newSport = {
                  key: sport.pos,
                  id: sport.id,
                  desc: sport.desc,
                  pos: sport.pos,
              };
              this.setState((prevState) => ({
                  sports: [...prevState.sports, newSport],
                }));
          });
      })
      .catch((err) => message.error("Error: " + err));
  };
  reloadSports = () => {
    this.setState({ sports: [] });
    this.loadSports();
  };

  render() {
    return (
      <>
        <Table className="table-striped-rows" dataSource={this.state.sports} columns={this.columns} pagination={{ pageSize: 20 }} />
      </>
    );
  }
}
export default Sport;