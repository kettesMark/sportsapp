import { Table, message } from "antd";
import React from "react";
import withRouter from './withRouter';

class Outcome extends React.Component {
    state = { 
      outcomes: [],
      sportId: this.props.params.sportId,
      eventId: this.props.params.eventId,
    };
  

  columns = [
    {
        title: "#",
        dataIndex: "key",
        key: "key",
        sorter: (a, b) => a.key - b.key,
        defaultSortOrder: "ascend",
    },
    {
        title: "Description",
        dataIndex: "desc",
        key: "desc",
    },
    {
        title: "Fractional odds",
        dataIndex: "pr",
        key: "pr",
    },
    {
        title: "Decimal odds",
        dataIndex: "prd",
        key: "prd",
    },
  ]
  
  componentDidMount() {
    this.loadOutcomes();
  }

  loadOutcomes = () => {
      const outcomesUrl = "/sports/"+this.state.sportId+"/events/"+this.state.eventId
      fetch(outcomesUrl)
      .then((data) => {
        if (data.ok) {
          return data.json();
        }
        throw new Error("Network error.");
      })
      .then((data) => {
          data.forEach((outcResp) =>{
              const newOutcome = {
                  key: (outcResp.pos == null) ? outcResp.id : outcResp.pos,
                  desc: outcResp.desc,
                  pos: outcResp.pos,
                  prd: outcResp.prd,
                  pr: outcResp.pr,
              };
              this.setState((prevState) => ({
                outcomes: [...prevState.outcomes, newOutcome],
                }));
          });
      })
      .catch((err) => message.error("Error: " + err));
  };
  reloadOutcomes = () => {
    this.setState({ outcomes: [] });
    this.loadOutcomes();
  };

  render() {
    return (
      <>
        <Table className="table-striped-rows" dataSource={this.state.outcomes} columns={this.columns} pagination={{ pageSize: 20 }} rowKey="key" />
        <div id="go-back-cont">
          <button onClick={() => this.props.navigate(-1)}>Go back</button>
        </div>
      </>
    );
  }
}
export default withRouter(Outcome);