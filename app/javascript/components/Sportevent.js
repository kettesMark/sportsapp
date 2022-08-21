import { Table, message } from "antd";
import React from "react";
import withRouter from './withRouter';
import { Link, useNavigate } from "react-router-dom";

class Sportevent extends React.Component {
  state = { 
    events: [],
    id: this.props.params.sportId,
  };

  columns = [
    {
      title: "#",
      dataIndex: "pos",
      key: "pos",
      sorter: (a, b) => a.pos - b.pos,
        defaultSortOrder: "ascend",
    },
    {
      title: "ID",
      dataIndex: "id",
      key: "id",
    },
    {
      title: "Competition",
      dataIndex: "comp_desc",
      key: "comp_desc",
    },
    {
      title: "Description",
      dataIndex: "desc",
      key: "desc",
    },
    {
      title: "Outcomes",
      dataIndex: "id",
      render: (id) => <Link to={`/events/${this.state.id}/outcomes/${id}`} key={id}> {"Show outcomes"} </Link>
    }
  ]
  
  componentDidMount() {
    this.loadEvents();
  }

  loadEvents = () => {
      const eventsUrl = "/sports/"+this.state.id
      fetch(eventsUrl)
      .then((data) => {
        if (data.ok) {
          return data.json();
        }
        throw new Error("Network error.");
      })
      .then((data) => {
          data.forEach((eventResp) =>{
              const newEvent = {
                  key: eventResp.pos,
                  id: eventResp.id,
                  desc: eventResp.desc,
                  pos: eventResp.pos,
                  comp_desc: eventResp.comp_desc,
              };
              this.setState((prevState) => ({
                  events: [...prevState.events, newEvent],
                }));
          });
      })
      .catch((err) => message.error("Error: " + err));
  };
  reloadEvents = () => {
    this.setState({ events: [] });
    this.loadEvents();
  };

  render() {
    return (
      <>
        <Table className="table-striped-rows" dataSource={this.state.events} columns={this.columns} pagination={{ pageSize: 20 }} rowKey="pos"/>
        <div id="go-back-cont">
          <button onClick={() => this.props.navigate(-1)}>Go back</button>
        </div>
      </>
    );
  }
}
export default withRouter(Sportevent);