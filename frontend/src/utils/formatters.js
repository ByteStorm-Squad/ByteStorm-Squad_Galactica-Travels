export function currency(value) {
    const formatter = new Intl.NumberFormat('en-US', {
    style: 'currency',
    currency: 'LKR'});
    return formatter.format(value).replace("LKR", "Rs.")
  };

export function formatSQLDateTime(sqlDateTime) {
    const options = { year: 'numeric', month: 'short', day: 'numeric', hour: 'numeric', minute: 'numeric', hour12: true };
    const dateTime = new Date(sqlDateTime);
    return dateTime.toLocaleDateString(undefined, options);
  }